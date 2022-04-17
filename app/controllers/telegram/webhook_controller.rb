# frozen_string_literal: true

class Telegram::WebhookController < Telegram::Bot::UpdatesController
  after_action :update_resources, :current_membership
  after_action :target_user_membership, only: %i[ban! forgive!]
  after_action :delete_message, only: %i[ban! forgive! mode! air_alert!]

  def ban!(*)
    return unless admin?

    target_user.bans.active.update(active: false)
    target_user.bans.create(chat: current_chat)
  end

  def forgive!(*)
    target_user.bans.active.where(chat: current_chat).update(active: false) if admin?
  end

  def mode!(word = nil, *)
    current_chat.update(emoji_mode: word&.downcase == Constants::ON) if admin?
  end

  def air_alert!(word = nil, *)
    current_chat.update(air_alert_mode: word&.downcase == Constants::ON) if admin?
  end

  # rubocop:disable Style/GuardClause
  def message(*)
    if (message_not_allowed? && (banned_user? || emoji_mode? || (air_alert_enabled? && air_alert?))) || banned_channel?
      delete_message
    end
  end
  # rubocop:enable Style/GuardClause

  def action_missing(action, *_args)
    super
    message
  rescue StandardError => e
    Rails.logger.error(e.message)
  end

  private

  def air_alert_enabled?
    current_chat.air_alert_mode?
  end

  # rubocop:disable Metrics/AbcSize
  def air_alert?
    if air_alert.updated_at < Time.zone.now - AirAlert::ALERT_CHECK_PERIOD
      places = HTTParty.get(AirAlert::ALERT_URL)['alerts'].map { |place| place['n'] }
      air_alert.update(places:, updated_at: Time.zone.now)
    end
    (air_alert.places & current_chat.alert_places).any?
  rescue StandardError
    false
  end
  # rubocop:enable Metrics/AbcSize

  def message_not_allowed?
    payload[:text].to_s.match?(/[\p{L}\x00-\x7F]/) || !payload[:sticker]
  end

  def delete_message
    bot.delete_message(chat_id: current_chat.telegram_id, message_id: payload[:message_id])
  end

  def banned_user?
    current_user.bans.active.exists?(chat: current_chat)
  end

  def banned_channel?
    Channel.exists?(banned: true, telegram_id: payload.dig(:forward_from_chat, :id))
  end

  def emoji_mode?
    current_chat.emoji_mode?
  end

  def admin?
    Membership.admin_role.exists?(chat: current_chat, user: current_user)
  end

  def current_chat
    @current_chat ||= Chat.create_with(chat_params).find_or_create_by(telegram_id: chat[:id])
  end

  def current_user
    @current_user ||= User.create_with(user_params).find_or_create_by(telegram_id: from[:id])
  end

  def update_resources
    current_user.update(user_params) && current_chat.update(chat_params)
  end

  def current_membership
    @current_membership ||= current_user.memberships.find_or_create_by(chat: current_chat)
  end

  def target_user
    @target_user ||= User.create_with(target_user_params)
                         .find_or_create_by(telegram_id: target_user_params[:telegram_id])
  end

  def target_user_membership
    @target_user_membership ||= target_user.memberships.find_or_create_by(chat: current_chat)
  end

  def air_alert
    @air_alert ||= AirAlert.first
  end

  def payload
    super.with_indifferent_access
  end

  def user_params
    @user_params ||= from.slice(:first_name, :last_name, :username).merge(bot: from[:is_bot])
  end

  def chat_params
    @chat_params ||= chat.slice(:title)
  end

  def target_user_params
    return @target_user_params if @target_user_params

    params = payload.dig(:reply_to_message, :from)
    @target_user_params = params.slice(:first_name, :last_name, :username)
                                .merge(bot: params[:is_bot], telegram_id: params[:id])
  end
end
