# frozen_string_literal: true

module Telegram::V1
  module Chat::Interactor
    class ControlMessage < ApplicationInteractor
      def call
        return unless context.message_restricted?

        context.bot.delete_message(chat_id: context.current_chat.telegram_id, message_id: context.params[:message_id])
      end
    end
  end
end
