# frozen_string_literal: true

module Services
  module Ecf
    class OutputPaymentPerParticipant
      include InitializeWithConfig

      def call
        output_payment_per_participant
      end

    private

      def output_payment_per_participant
        FromContract.call(config.contract, :band_a).send(:per_participant) * FromContract.call(config.contract, :band_a).send(:weighting)
      end
    end
  end
end
