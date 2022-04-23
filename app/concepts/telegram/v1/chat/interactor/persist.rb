# frozen_string_literal: true

module Telegram::V1
  module Chat::Interactor
    class Persist < ApplicationInteractor
      def call
        TelegramParams.call(context)
        context.chat = ::Chat.create_with(context.telegram_params)
                             .find_or_create_by(telegram_id: context.params.dig(:chat, :id))
      end
    end
  end
end
