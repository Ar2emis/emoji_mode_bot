# frozen_string_literal: true

Ransack.configure do |config|
  %w[contained_within contained_within_or_equals contains contains_or_equals overlaps].each do |predicate|
    config.add_predicate predicate, arel_predicate: predicate, wants_array: true
  end
end
