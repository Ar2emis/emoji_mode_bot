# frozen_string_literal: true

class CreateAirAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :air_alerts, id: :uuid do |t|
      t.string :places, array: true, default: []
      t.timestamps
    end
  end
end
