# frozen_string_literal: true

module NpqCalculationSteps
  step "there's an qualification with a per-participant price of £:decimal_placeholder" do |value|
    @price_per_participant = value
  end

  step "the recruitment target is :value" do |value|
    @recruitment_target = value.to_i
  end

  step "there are :value monthly service fee payments" do |value|
    @number_of_monthly_payments = value.to_i
  end

  step "the service fee payment schedule should be:" do |table|
    result = calculate
    aggregate_failures "service fees" do
      table.hashes.each do |row|
        month = row["Month"].to_i
        expected_service_fee_total = CurrencyParser.currency_to_big_decimal(row["Service Fee"])
        expect_with_context(result.dig(:output, :service_fees, :payment_schedule, month), expected_service_fee_total, "Payment for month '#{month}'")
      end
    end
  end

  step "the service fee total should be £:decimal_placeholder" do |expected_amount|
    result = calculate
    expect(result.dig(:output, :service_fees, :payment_schedule).values.sum).to eq(expected_amount)
  end

  step "there are the following retention points:" do |table|
    @retention_table = {}

    table.hashes.each do |row|
      @retention_table[row["Payment Type"]] = {
        retained_participants: row["Retained Participants"].to_i,
        expected_per_participant_variable_payment: CurrencyParser.currency_to_big_decimal(row["Expected Per-Participant Variable Payment"]),
        expected_variable_payment_subtotal: CurrencyParser.currency_to_big_decimal(row["Expected Variable Payment Subtotal"]),
      }
    end
  end

  def calculate
    retention_points = {}
    @retention_table.each do |retention_point, values|
      retention_points[retention_point] = {
        retained_participants: values[:retained_participants],
        percentage: values[:percentage],
      }
    end

    config = {
      recruitment_target: @recruitment_target,
      number_of_service_fee_payments: @number_of_monthly_payments,
      per_participant_price: @price_per_participant,
      retention_points: retention_points,
    }
    NpqPaymentCalculationService.new(config).calculate
  end

  step "expected variable payments should be as above" do
    result = calculate
    aggregate_failures "variable payments" do
      @retention_table.each do |retention_point, values|
        expect_with_context(
          result.dig(:output, :variable_payments, retention_point, :per_participant), values[:expected_per_participant_variable_payment], "Payment for retention point '#{retention_point}'"
        )

        expect_with_context(
          result.dig(:output, :variable_payments, retention_point, :total_variable_payment), values[:expected_variable_payment_subtotal], "Total variable payment '#{retention_point}'"
        )
      end
    end
  end
end

RSpec.configure do |config|
  config.include NpqCalculationSteps, npq: true
end
