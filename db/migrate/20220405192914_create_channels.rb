# frozen_string_literal: true

class CreateChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :channels, id: :uuid do |t|
      t.bigint :telegram_id, null: false
      t.string :name, null: false
      t.boolean :banned, default: false

      t.timestamps
    end
  end
end
