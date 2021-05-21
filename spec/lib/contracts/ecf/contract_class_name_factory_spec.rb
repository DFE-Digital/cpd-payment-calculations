# frozen_string_literal: true

require_relative '../../../../lib/contracts/ecf/contract_class_name_factory'

describe Contracts::Ecf::ContractClassNameFactory do
  it "returns the correct class when generated with 'example' contract" do
    expect(described_class.call("example")).to eq("Contracts::Ecf::Example::Contract")
  end
end
