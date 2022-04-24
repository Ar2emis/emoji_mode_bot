# frozen_string_literal: true

module Telegram::V1
  class ApplicationJob
    include Sidekiq::Job
  end
end
