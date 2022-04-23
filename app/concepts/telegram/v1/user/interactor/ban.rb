# frozen_string_literal: true

module Telegram::V1
  module User::Interactor
    class Ban < ApplicationInteractor
      UNITS = {
        s: :seconds,
        h: :hours,
        d: :days,
        w: :weeks,
        M: :months,
        y: :years
      }.freeze

      delegate :current_user, to: :context
      authorize :user, through: :current_user

      def call
        return unless allowed_to?(:ban?, context.current_chat, with: Telegram::V1::User::Policy)

        banned_until if context.duration
        ban_params
        create_ban
      end

      private

      def banned_until
        number = context.duration.to_i
        unit = context.duration.last&.to_sym
        context.banned_until = number.public_send(UNITS.fetch(unit, :minutes)).from_now
      end

      def ban_params
        context.ban_params = {
          ban_type: context.banned_until ? :temporary : :permanent, blocked_until: context.banned_until
        }
      end

      def create_ban
        context.target_user.bans.active.update(active: false)
        context.target_user.bans.create(chat: context.current_chat, **context.ban_params)
      end
    end
  end
end
