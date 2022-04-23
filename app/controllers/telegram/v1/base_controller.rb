# frozen_string_literal: true

module Telegram::V1
  class BaseController < Telegram::Bot::UpdatesController
    include Interactable
    include Matchable
    rescue_from(StandardError) { |e| Rails.logger.error(e.message) }

    alias params payload

    after_action :sync_resources

    private

    def current_chat
      @current_chat ||= interact(Chat::Interactor::Persist).chat
    end

    def current_user
      @current_user ||= interact(User::Interactor::Persist).user
    end

    def sync_resources
      organize Common::Organizer::SyncResources, user: current_user, chat: current_chat
    end
  end
end
