# frozen_string_literal: true

class MembershipDecorator < Draper::Decorator
  decorates_association :user
  delegate_all

  def user_name
    "#{role.titleize}: #{user.full_name}"
  end

  def chat_name
    "#{role.titleize}: #{chat.title}"
  end
end
