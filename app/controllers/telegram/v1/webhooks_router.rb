# frozen_string_literal: true

module Telegram::V1
  module WebhooksRouter
    module_function

    def dispatch(bot, update)
      update = update.with_indifferent_access
      Telegram::V1::Common::Interactor::RouteManager.call(update:, bot:).controller.dispatch(bot, update)
    end
  end
end
