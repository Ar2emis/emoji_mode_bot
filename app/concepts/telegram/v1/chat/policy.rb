# frozen_string_literal: true

module Telegram::V1
  module Chat
    class Policy < ApplicationPolicy
      alias_rule :update_settings?, to: :admin?

      def admin?
        ::Membership.admin_role.exists?(chat: record, user:)
      end
    end
  end
end
