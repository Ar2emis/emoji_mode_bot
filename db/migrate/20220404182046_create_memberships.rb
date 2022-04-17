# frozen_string_literal: true

class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :chat, null: false, foreign_key: true, type: :uuid
      t.integer :role, default: Membership.roles[:regular]

      t.timestamps
    end
  end
end
