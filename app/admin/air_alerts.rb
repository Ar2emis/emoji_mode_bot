# frozen_string_literal: true

ActiveAdmin.register AirAlert do
  menu label: AirAlert.name.titleize, url: -> { admin_air_alert_path(AirAlert.first) }

  actions :show

  show title: ->(_) { AirAlert.name.titleize } do
    attributes_table do
      row(:updated_at)
      row(:places) do
        next if air_alert.places.none?

        ul { air_alert.places.map { |place| li place } }
      end
    end
  end

  controller do
    def index
      redirect_to admin_air_alert_path(AirAlert.first)
    end
  end
end
