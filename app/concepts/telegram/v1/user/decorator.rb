# frozen_string_literal: true

module Telegram::V1
  module User
    class Decorator < ApplicationDecorator
      delegate_all

      def full_name
        @full_name ||= [first_name, last_name].select(&:present?).join(' ')
      end
    end
  end
end
