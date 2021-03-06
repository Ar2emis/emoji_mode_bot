# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  enum :role, { regular: 0, admin: 1 }, suffix: true
end
