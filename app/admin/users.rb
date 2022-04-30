# frozen_string_literal: true

ActiveAdmin.register User do
  decorate_with Telegram::V1::User::Decorator
  actions :index, :show, :edit, :update

  permit_params memberships_attributes: [:role]

  filter :search_by_name, as: :string
  filter :memberships_role, label: 'Role', as: :select,
                            collection: Membership.roles.map { |type, value| [type.titleize, value] }
  filter :memberships_chat_id, label: Chat.name, as: :select, collection: -> { Chat.all }

  index do
    column :full_name
    column :username
    column :bot
    actions
  end

  show do
    attributes_table do
      row :full_name
      row :username
      row :bot
      row :created_at
      row :updated_at
    end

    panel Membership.name do
      table_for user.memberships.includes(:chat) do
        column(:chat)
        tag_column(:role)
        column(:actions) { |membership| link_to 'Edit', edit_admin_membership_path(membership) }
      end
    end

    next if user.bans.active.none?

    panel Ban.name do
      table_for user.bans.active.includes(:chat) do
        column(:chat)
        tag_column(:type) { |ban| ban.ban_type.titleize }
        column(:blocked_until)
        column(:actions) { |ban| link_to 'Forgive', forgive_admin_ban_path(ban), method: :put }
      end
    end
  end
end
