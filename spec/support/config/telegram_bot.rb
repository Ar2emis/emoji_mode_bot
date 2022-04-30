# frozen_string_literal: true

RSpec.configure do |config|
  config.after { Telegram.bots.each_value(&:reset) }
end
