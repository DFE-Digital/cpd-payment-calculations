# frozen_string_literal: true

require_relative '../../../../../lib/contracts/ecf/banding'

module Contracts
  module Ecf
    module Example
      class BandB < Contracts::Ecf::Banding
        min 2001
        max 4000
        per_participant 979
        weighting 0.30
      end
    end
  end
end

