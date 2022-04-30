# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    telegram_id { rand(1..1_000_000_000) }
    bot { false }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    username { FFaker::Internet.user_name }
  end
end
