# frozen_string_literal: true

ActiveAdmin.register Channel do
  permit_params :telegram_id, :name, :banned

  filter :telegram_id
  filter :search_by_name, as: :string

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :telegram_id
      f.input :banned
    end
    f.actions
  end

  index do
    column(:name) { |channel| link_to channel.name, admin_channel_path(channel) }
    column :telegram_id
    column :banned
  end
end
