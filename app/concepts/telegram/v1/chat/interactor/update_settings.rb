# frozen_string_literal: true

module Telegram::V1
  module Chat::Interactor
    class UpdateSettings < ApplicationInteractor
      delegate :current_user, to: :context
      authorize :user, through: :current_user

      def call
        return unless allowed_to?(:update_settings?, context.current_chat, with: Telegram::V1::Chat::Policy)

        context.current_chat.update(context.setting => context.value&.downcase == ::Constants::ON)
      end
    end
  end
end
