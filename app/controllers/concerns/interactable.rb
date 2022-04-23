# frozen_string_literal: true

module Interactable
  extend ActiveSupport::Concern

  def interact(interactor, params: nil, **kwargs)
    interactor.call(params: params || self.params, **kwargs)
  end

  alias organize interact
end
