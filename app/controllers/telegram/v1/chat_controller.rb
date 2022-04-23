# frozen_string_literal: true

module Telegram::V1
  class ChatController < BaseController
    def mode!(value = nil, *)
      interact Chat::Interactor::UpdateSettings, current_user:, current_chat:, setting: :emoji_mode, value:
    end

    def air_alert!(value = nil, *)
      interact Chat::Interactor::UpdateSettings, current_user:, current_chat:, setting: :air_alert_mode, value:
    end

    def message(*)
      organize Chat::Organizer::ProcessMessage, current_user:, current_chat:, bot:
    end

    def action_missing(action, *_args)
      super
      message
    rescue StandardError => e
      Rails.logger.error(e.message)
    end
  end
end
