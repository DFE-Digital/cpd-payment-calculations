# frozen_string_literal: true

require_relative '../../../../../lib/contracts/ecf/banding'

module Contracts
  module Ecf
    module Example
      class BandA < Contracts::Ecf::Banding
        min 0
        max 2000
        per_participant 995
        weighting 0.6
      end
    end
  end
end
