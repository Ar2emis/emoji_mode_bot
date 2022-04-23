# frozen_string_literal: true

module Telegram::V1
  module Chat::Interactor
    class Update < ApplicationInteractor
      def call
        TelegramParams.call(context)
        context.chat.update(context.telegram_params)
      end
    end
  end
end
