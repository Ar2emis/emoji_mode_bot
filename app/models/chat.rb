# frozen_string_literal: true

class Chat < ApplicationRecord
  include PgSearch::Model

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :bans, dependent: :destroy

  multisearchable against: :title
  pg_search_scope :search_by_title, against: :title, using: { trigram: { threshold: 0.25 } }

  def self.ransackable_scopes(_auth = nil)
    super << :search_by_title
  end
end
