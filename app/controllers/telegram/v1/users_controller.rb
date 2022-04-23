# frozen_string_literal: true

module Telegram::V1
  class UsersController < BaseController
    match_route { |command:, **| %i[ban forgive].include?(command) }

    after_action :target_user_membership, only: %i[ban! forgive!]

    def ban!(duration = nil, *)
      interact User::Interactor::Ban, current_user:, current_chat:, target_user:, duration:
    end

    def forgive!(*)
      interact User::Interactor::Forgive, current_user:, current_chat:, target_user:
    end

    private

    def target_user
      @target_user ||= interact(User::Interactor::Persist, target?: true).user
    end

    def target_user_membership
      @target_user_membership ||= interact(
        User::Membership::Interactor::Persist, user: target_user, chat: current_chat
      ).membership
    end
  end
end
