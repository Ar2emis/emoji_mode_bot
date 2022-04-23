# frozen_string_literal: true

module Telegram
  module V1
    class ApplicationInteractor
      include Interactor
      include ActionPolicy::Behaviour
    end
  end
end
