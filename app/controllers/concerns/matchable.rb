# frozen_string_literal: true

module Matchable
  extend ActiveSupport::Concern

  class_methods do
    def match_route?(**kwargs)
      @matcher[**kwargs]
    end

    def match_route(&block)
      @matcher = block
    end
  end
end
