# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.bigint :telegram_id, null: false, index: true
      t.boolean :bot, default: false
      t.string :first_name, default: ''
      t.string :last_name, default: ''
      t.string :username

      t.timestamps
    end
  end
end
