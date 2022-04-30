# frozen_string_literal: true

FactoryBot.define do
  factory :membership do
    user { create(:user) }
    chat { create(:chat) }
    role { :regular }
  end
end
