# frozen_string_literal: true

QUALIFICATION_NAME = "foo"

describe NpqPaymentCalculationService do
  let(:config) do
    {
      recruitment_target: 2000,
      price_per_participant: BigDecimal(456.78, 10),
      number_of_monthly_payments: 19,
      retention_points: {
        "first": {
          retained_participants: 100,
          percentage: 20,
        },
        "second": {
          retained_participants: 70,
          percentage: 20,
        },
        "completion": {
          retained_participants: 70,
          percentage: 20,
        },
      },
    }
  end

  describe "#service_fee_schedule" do
    let(:result) { NpqPaymentCalculationService.new(config).service_fee_schedule }

    it "includes config in the output" do
      expect(result[:input]).to eq(config)
    end

    it "returns BigDecimal for all money outputs" do
      result.dig(:output, :service_fee_payment_schedule).each do |_key, value|
        expect(value).to be_a(BigDecimal)
      end
    end
  end

  describe "#variable_fee_schedule" do
    let(:result) { NpqPaymentCalculationService.new(config).variable_fee_schedule }

    it "returns Number for all other numeric outputs" do
      result.dig(:output, :variable_fee_schedule).each do |_key, value|
        expect(value[:total_variable_fee]).to be_a(Numeric)
      end
    end
  end
end
