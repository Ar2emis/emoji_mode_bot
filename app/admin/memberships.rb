# frozen_string_literal: true

ActiveAdmin.register Membership do
  decorate_with Telegram::V1::User::Membership::Decorator
  permit_params :role

  menu false
  actions :edit, :update

  breadcrumb do
    [
      link_to(User.model_name.plural, admin_users_path),
      link_to(resource.user.decorate.full_name, admin_user_path(resource.user))
    ]
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :role
    end
    f.actions do
      f.action :submit
      f.cancel_link admin_user_path(membership.user)
    end
  end

  controller do
    def update
      super do |success, failure|
        success.html { redirect_to admin_user_path(resource.user) }
        failure.html { render :edit }
      end
    end
  end
end
