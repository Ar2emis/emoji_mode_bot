# frozen_string_literal: true

require 'ostruct'
require 'date'
require 'json'

require 'telegram/bot'
require 'httparty'

class WebhooksController < Telegram::Bot::UpdatesController
  ON = 'on'
  CHAT_KEY = '@all'
  AIR_ALERT_KEY = '@air_alert'
  ALERT_URL = 'https://war-api.ukrzen.in.ua/alerts/api/v2/alerts/active.json'
  ALERT_CHECK_PERIOD = 2.minutes

  @chats = {}
  @banned_channels = (ENV['CHANNELS'] || []).split(',').map(&:strip).to_h { |id| [id, nil] }
  @admins = (ENV['ADMINS'] || []).split(',').map(&:strip).to_h { |username| [username, nil] }
  @alert_places = (ENV['PLACES'] || []).split(',').map(&:strip)
  @air_alert = OpenStruct.new(on: false, updated_at: DateTime.now - ALERT_CHECK_PERIOD)

  def status!(*)
    return unless admin?

    delete_message
    info = { chat: current_chat, air_alert: air_alert.to_h, alert_places: self.class.alert_places }
    bot.send_message(chat_id: chat['id'], text: info.to_json)
  end

  def add!(*)
    current_chat[nickname] = nil if admin? && nickname
    delete_message
  end

  def delete!(*)
    current_chat.delete(nickname) if admin? && nickname
    delete_message
  end

  def mode!(word = nil, *)
    current_chat[CHAT_KEY] = word.downcase == ON if admin?
    delete_message
  end

  def air_alert!(word = nil, *)
    current_chat[AIR_ALERT_KEY] = word.downcase == ON if admin?
    delete_message
  end

  def message(*)
    if (message_not_allowed? && (banned_user? || emoji_mode? || (air_alert_enabled? && air_alert?))) || banned_channel?
      delete_message
    end
  end

  def action_missing(action, *_args)
    super
    message
  end

  private

  def air_alert_enabled?
    current_chat[AIR_ALERT_KEY]
  end

  def air_alert?
    if air_alert.updated_at < DateTime.now - ALERT_CHECK_PERIOD
      places = HTTParty.get(ALERT_URL)['alerts'].map { |place| place['n'] }
      air_alert.on = (places & self.class.alert_places).any?
      air_alert.updated_at = DateTime.now
    end
    air_alert.on
  rescue StandardError
    false
  end

  def message_not_allowed?
    payload['text'].to_s.match?(/[\p{L}\x00-\x7F]/) || !payload['sticker']
  end

  def delete_message
    bot.delete_message(chat_id: chat['id'], message_id: payload['message_id'])
  end

  def banned_user?
    current_chat.key?(from['username'])
  end

  def banned_channel?
    self.class.banned_channels.key?(payload.dig('forward_from_chat', 'id')&.to_s)
  end

  def emoji_mode?
    current_chat[CHAT_KEY]
  end

  def admin?
    self.class.admins.key?(from['username'])
  end

  def nickname
    payload['text']&.split('@')&.last
  end

  def current_chat
    self.class.chats[chat['id']] ||= {}
  end

  def air_alert
    self.class.air_alert
  end

  class << self
    attr_reader :chats, :logger, :admins, :banned_channels, :air_alert, :alert_places
  end
end
