# frozen_string_literal: true
require_relative './framework_constants'

module Contracts
  module Ecf
    class Base
      include Contracts::Ecf::FrameworkConstants
      framework_constants :recruitment_target, :set_up_fees, :uplift_target, :uplift_amount, :band_a, :band_b, :band_c

      def weighted_average
        band_a.allocation + band_b.allocation + band_c.allocation
      end

      def total_service_fee
        per_participant_service_fee
      end
    end
  end
end
