# frozen_string_literal: true

module Telegram::V1
  module Chat::Organizer
    class ProcessMessage < ApplicationOrganizer
      organize Telegram::V1::Chat::Interactor::ValidateMessage, Telegram::V1::Chat::Interactor::ControlMessage
    end
  end
end
