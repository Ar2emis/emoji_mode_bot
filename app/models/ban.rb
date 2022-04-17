# frozen_string_literal: true

class Ban < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  enum :ban_type, { permanent: 0, temporary: 1 }

  scope :active, lambda {
    t = arel_table
    where(
      t[:ban_type].eq(:permanent).and(t[:active]).or(
        t[:ban_type].eq(:temporary).and(t[:blocked_until].gt(Time.zone.now))
      )
    )
  }
end
