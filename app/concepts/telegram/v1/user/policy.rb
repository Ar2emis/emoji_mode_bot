# frozen_string_literal: true

module Telegram::V1
  module User
    class Policy < ApplicationPolicy
      alias_rule :ban?, :forgive?, to: :admin?

      def admin?
        ::Membership.admin_role.exists?(chat: record, user:)
      end
    end
  end
end
