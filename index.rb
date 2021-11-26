# frozen_string_literal: true

require 'logger'
require 'telegram/bot'

TOKEN = '2146451624:AAGwss7255GeDrVSo_9AwSozAebIM4sV0xs'

class WebhooksController < Telegram::Bot::UpdatesController
  @usernames = []

  def add!(*)
    return unless admin? && nickname

    self.class.usernames << nickname
  end

  def delete!(*)
    return unless admin? && nickname

    self.class.usernames.delete(nickname)
  end

  def message(message)
    if !banned? ||
       message['text'].present? &&
       !message['text'].match?(/[\p{L}\x00-\x7F]/) ||
       message['sticker']
      return
    end

    bot.delete_message(chat_id: message['chat']['id'], message_id: message['message_id'])
  end

  private

  def banned?
    self.class.usernames.include?(payload['from']['username'])
  end

  def admin?
    [311_970_224, 363923400].include?(payload.dig('from', 'id'))
  end

  def nickname
    nickname = payload['text']&.split('@')&.last
  end

  class << self
    attr_reader :usernames
  end
end

bot = Telegram::Bot::Client.new(TOKEN)
logger = Logger.new($stdout)

poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
