# frozen_string_literal: true

# frozen_string_literal: true

module Telegram::V1
  module User::Membership
    class Decorator < ApplicationDecorator
      decorates_association :user
      delegate_all

      def user_name
        "#{role.titleize}: #{user.full_name}"
      end

      def chat_name
        "#{role.titleize}: #{chat.title}"
      end
    end
  end
end
