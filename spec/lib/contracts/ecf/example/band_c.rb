# frozen_string_literal: true

require_relative '../../../../../lib/contracts/ecf/banding'

module Contracts
  module Ecf
    module Example
      class BandC < Contracts::Ecf::Banding
        min 4001
        max 8_000_000
        per_participant 966
        weighting 0.1
      end
    end
  end
end
