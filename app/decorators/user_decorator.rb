# frozen_string_literal: true

class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    @full_name ||= [first_name, last_name].select(&:present?).join(' ')
  end
end
