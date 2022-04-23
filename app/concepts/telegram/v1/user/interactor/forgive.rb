# frozen_string_literal: true

module Telegram::V1
  module User::Interactor
    class Forgive < ApplicationInteractor
      delegate :current_user, to: :context
      authorize :user, through: :current_user

      def call
        return unless allowed_to?(:forgive?, context.current_chat, with: Telegram::V1::User::Policy)

        context.target_user.bans.active.where(chat: context.current_chat).update(active: false)
      end
    end
  end
end
