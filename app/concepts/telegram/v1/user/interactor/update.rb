# frozen_string_literal: true

module Telegram::V1
  module User::Interactor
    class Update < ApplicationInteractor
      def call
        TelegramParams.call(context)
        context.user.update(context.telegram_params)
      end
    end
  end
end
