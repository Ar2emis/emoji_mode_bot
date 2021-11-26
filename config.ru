# frozen_string_literal: true

require_relative 'webhooks_controller'

TOKEN = ENV['TOKEN']

bot = Telegram::Bot::Client.new(TOKEN)

map "/#{TOKEN}" do
  run Telegram::Bot::Middleware.new(bot, WebhooksController)
end
