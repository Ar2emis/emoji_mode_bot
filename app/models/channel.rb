# frozen_string_literal: true

class Channel < ApplicationRecord
  include PgSearch::Model

  multisearchable against: :name
  pg_search_scope :search_by_name, against: :name, using: { trigram: { threshold: 0.25 } }

  def self.ransackable_scopes(_auth = nil)
    super << :search_by_name
  end
end
