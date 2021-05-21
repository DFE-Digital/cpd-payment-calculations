# frozen_string_literal: true

require_relative '../../../../../lib/contracts/ecf/base'
require_relative './band_a'
require_relative './band_b'
require_relative './band_c'

module Contracts
  module Ecf
    module Example
      class Contract < Contracts::Ecf::Base
        uplift_target 0.33
        uplift_amount 100
        recruitment_target 2000
        set_up_fees 149_861
        band_a Contracts::Ecf::Example::BandA
        band_b Contracts::Ecf::Example::BandB
        band_c Contracts::Ecf::Example::BandC
      end
    end
  end
end
