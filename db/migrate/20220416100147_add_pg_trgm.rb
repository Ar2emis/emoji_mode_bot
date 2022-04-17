# frozen_string_literal: true

class AddPgTrgm < ActiveRecord::Migration[7.0]
  def up
    execute 'CREATE EXTENSION pg_trgm;'
  end

  def down
    execute 'DROP EXTENSION pg_trgm;'
  end
end
