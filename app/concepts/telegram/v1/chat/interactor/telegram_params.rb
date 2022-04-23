# frozen_string_literal: true

module Telegram::V1
  module Chat::Interactor
    class TelegramParams < ApplicationInteractor
      def call
        context.telegram_params = context.params[:chat].slice(:title)
      end
    end
  end
end
