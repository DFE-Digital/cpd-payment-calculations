# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'
require_relative 'banding_constants'

module Contracts
  module Ecf
    class Banding
      include BandingConstants
      banding_constants :min, :max, :per_participant, :weighting

      def should_calculate?(overall_number)
        min > overall_number && max <= overall_number
      end

      def calculation_amount(overall_number)
        if should_calculate?(overall_number)
          overall_number < max ? overall_number - min : max - min
        else
          0
        end
      end

      def allocation
        per_participant * weighting
      end

    end
  end
end
