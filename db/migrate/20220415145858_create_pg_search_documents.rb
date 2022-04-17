# frozen_string_literal: true

class CreatePgSearchDocuments < ActiveRecord::Migration[7.0]
  def up
    say_with_time('Creating table for pg_search multisearch') do
      create_table :pg_search_documents, type: :uuid do |t|
        t.text :content
        t.belongs_to :searchable, type: :uuid, polymorphic: true, index: true
        t.timestamps null: false
      end
    end
  end

  def down
    say_with_time('Dropping table for pg_search multisearch') do
      drop_table :pg_search_documents
    end
  end
end
