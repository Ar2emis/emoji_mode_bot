# frozen_string_literal: true

ActiveAdmin.register Chat do
  actions :all, except: %i[new create destroy]

  permit_params :emoji_mode, :air_alert_mode, alert_places: []

  filter :search_by_title, as: :string
  filter :memberships_role, label: 'Role', as: :select,
                            collection: Membership.roles.map { |type, value| [type.titleize, value] }
  filter :memberships_user_id, label: User.name, as: :select, collection: -> { User.all }
  filter :bans_user_id, label: 'banned', as: :select, collection: -> { User.joins(:bans).decorate }
  filter :emoji_mode
  filter :air_alert_mode
  filter :alert_places_overlaps, label: 'alert places', as: :select, multiple: true, collection: AirAlert::PLACES

  index do
    column :title
    column :emoji_mode
    column :air_alert_mode
    actions
  end

  show do
    attributes_table do
      row :emoji_mode
      row :air_alert_mode
      row :alert_places
      row :created_at
      row :updated_at
    end
    panel User.name do
      table_for chat.users.decorate do
        column(:full_name) { |user| link_to user.full_name, admin_user_path(user) }
        column(:username)
        tag_column(:role) { |user| user.memberships.find_by(chat:).role }
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :emoji_mode
      f.input :air_alert_mode
      f.input :alert_places, as: :select, multiple: true, collection: AirAlert::PLACES
    end
    f.actions
  end

  controller do
    before_action :delete_empty_alert_places, only: [:update]

    private

    def delete_empty_alert_places
      params.dig(:chat, :alert_places).select!(&:present?)
    end
  end
end
