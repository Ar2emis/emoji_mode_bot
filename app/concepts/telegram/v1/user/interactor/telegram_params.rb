# frozen_string_literal: true

module Telegram::V1
  module User::Interactor
    class TelegramParams < ApplicationInteractor
      def call
        path = [:from]
        path.prepend(:reply_to_message) if context.target?
        context.telegram_params = context.params.dig(*path).slice(:first_name, :last_name, :username)
                                         .merge(bot: context.params.dig(*path, :is_bot))
      end
    end
  end
end
