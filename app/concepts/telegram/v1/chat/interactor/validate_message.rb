# frozen_string_literal: true

module Telegram::V1
  module Chat::Interactor
    class ValidateMessage < ApplicationInteractor
      def call
        context[:message_restricted?] = (message_not_allowed? && restrictions_exist?) || banned_channel?
      end

      private

      def message_not_allowed?
        context.params[:text] ? context.params[:text].match?(/[\p{L}\x00-\x7F]/) : !context.params.key?(:sticker)
      end

      def restrictions_exist?
        banned_user? || context.current_chat.emoji_mode? || (context.current_chat.air_alert_mode? && air_alert?)
      end

      def air_alert?
        (AirAlert.first.places & context.current_chat.alert_places).any?
      end

      def banned_user?
        context.current_user.bans.active.exists?(chat: context.current_chat)
      end

      def banned_channel?
        Channel.exists?(banned: true, telegram_id: context.params.dig(:forward_from_chat, :id))
      end
    end
  end
end
