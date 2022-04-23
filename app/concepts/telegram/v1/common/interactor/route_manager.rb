# frozen_string_literal: true

module Telegram::V1
  module Common::Interactor
    class RouteManager < ApplicationInteractor
      CONTROLLERS = [Telegram::V1::UsersController].freeze

      def call
        command_entity
        command if context.command_entity
        controller
      end

      def command_entity
        context.command_entity = context.update.dig(:message, :entities)&.find do |entity|
          entity[:type] == 'bot_command'
        end
      end

      def command
        command_range = (context.command_entity[:offset].next..context.command_entity[:length].pred)
        context.command = context.update.dig(:message, :text)[command_range].to_sym
      end

      def controller
        context.controller = CONTROLLERS.find do |controller|
          controller.match_route?(command: context.command, update: context.update)
        end || ChatController
      end
    end
  end
end
