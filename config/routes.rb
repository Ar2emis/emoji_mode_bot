# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope :admin do
    resources :memberships, only: []
  end

  telegram_webhook Telegram::WebhookController
end
