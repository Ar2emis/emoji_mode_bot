# frozen_string_literal: true

FactoryBot.define do
  factory :air_alert do
    places { AirAlert::PLACES.sample(rand(1..AirAlert::PLACES.size)) }
  end
end
