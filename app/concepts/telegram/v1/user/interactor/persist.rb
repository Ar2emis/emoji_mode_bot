# frozen_string_literal: true

module Telegram::V1
  module User::Interactor
    class Persist < ApplicationInteractor
      def call
        TelegramParams.call(context)
        context.user = ::User.create_with(context.telegram_params)
                             .find_or_create_by(telegram_id: context.params.dig(:from, :id))
      end
    end
  end
end
