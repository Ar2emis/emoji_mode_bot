# frozen_string_literal: true

ActiveAdmin.register Ban do
  menu false
  actions only: [:forgive]

  member_action :forgive, method: :put do
    resource.update(active: false)
    redirect_back_or_to admin_root_path, notice: 'User has been forgived'
  end
end
