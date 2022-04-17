# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats, id: :uuid do |t|
      t.bigint :telegram_id, null: false, index: true
      t.boolean :emoji_mode, default: false
      t.boolean :air_alert_mode, default: false
      t.string :title, null: false
      t.string :alert_places, array: true, default: []

      t.timestamps
    end
  end
end
