# frozen_string_literal: true

class CreateBans < ActiveRecord::Migration[7.0]
  def change
    create_table :bans, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :chat, null: false, foreign_key: true, type: :uuid
      t.integer :ban_type, default: Ban.ban_types[:permanent]
      t.boolean :active, default: true
      t.timestamp :blocked_until

      t.timestamps
    end
  end
end
