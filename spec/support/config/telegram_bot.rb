RSpec.configure do |config|
  config.after { Telegram.bots.each_value(&:reset) }
end
