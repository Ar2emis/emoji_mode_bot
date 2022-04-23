# frozen_string_literal: true

module Telegram::V1
  module Common::Organizer
    class SyncResources < ApplicationOrganizer
      organize Telegram::V1::User::Interactor::Update, Telegram::V1::Chat::Interactor::Update,
               Telegram::V1::User::Membership::Interactor::Persist
    end
  end
end
