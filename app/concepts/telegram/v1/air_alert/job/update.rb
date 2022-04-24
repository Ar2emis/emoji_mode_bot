# frozen_string_literal: true

module Telegram::V1
  module AirAlert::Job
    class Update < Telegram::V1::ApplicationJob
      sidekiq_options retry: false

      def perform
        Telegram::V1::AirAlert::Interactor::Update.call
      end
    end
  end
end
