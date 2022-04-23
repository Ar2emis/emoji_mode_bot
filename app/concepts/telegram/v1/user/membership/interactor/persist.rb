# frozen_string_literal: true

module Telegram::V1
  module User::Membership
    module Interactor
      class Persist < ApplicationInteractor
        def call
          context.membership = context.user.memberships.find_or_create_by(chat: context.chat)
        end
      end
    end
  end
end
