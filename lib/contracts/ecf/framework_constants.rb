# frozen_string_literal: true

require_relative '../../declarative_constants'

module Contracts
  module Ecf
    module FrameworkConstants
      class << self
        def included(base)
          base.class_eval do
            include DeclarativeConstants
            define_singleton_method(:framework_constants) do |*args|
              declarative_constants(*args)
            end
          end
        end
      end
    end
  end
end
