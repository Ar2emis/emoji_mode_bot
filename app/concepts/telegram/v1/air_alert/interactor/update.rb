# frozen_string_literal: true

module Telegram::V1
  module AirAlert::Interactor
    class Update < ApplicationInteractor
      def call
        context.air_alert = ::AirAlert.first
        update
      end

      private

      def update
        begin
          places = HTTParty.get(::AirAlert::ALERT_URL)['alerts'].map { |place| place['n'] }
        rescue StandardError => e
          Rails.logger.error(e.message)
          places = []
        end
        context.air_alert.update(places:)
      end
    end
  end
end
