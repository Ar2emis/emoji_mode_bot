# frozen_string_literal: true

FactoryBot.define do
  factory :chat do
    telegram_id { rand(1..1_000_000_000) }
    bot { false }
    emoji_mode { false }
    air_alert_mode { false }
    title { FFaker::Game.title }
    alert_places { AirAlert::PLACES.sample(rand(1..AirAlert::PLACES.size)) }
  end
end
