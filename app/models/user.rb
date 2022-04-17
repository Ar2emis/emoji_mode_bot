# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch::Model

  has_many :memberships, dependent: :destroy
  has_many :chats, through: :memberships
  has_many :bans, dependent: :destroy

  accepts_nested_attributes_for :memberships

  multisearchable against: %i[first_name last_name username]
  pg_search_scope :search_by_name, against: %i[first_name last_name username], using: { trigram: { threshold: 0.25 } }

  def self.ransackable_scopes(_auth = nil)
    super << :search_by_name
  end
end
