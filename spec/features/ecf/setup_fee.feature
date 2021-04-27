@ecf
Feature: ECF payment calculation engine

  Scenario Outline: Setup fees
    Given the setup fee is <setup_fee>
      And the recruitment target is <recruitment_target>
      And Band A per-participant price is <band_a>
    When I run the calculation
    Then the per-participant service fee should be reduced to <expected_service_fee>
      And the output payment per-participant should be unchanged at <expected_output_payment>
    Examples:
      | setup_fee | recruitment_target | band_a | expected_service_fee | expected_output_payment |
      | £150,000  | 2000               | £1,400 | £485                 | £840                    |
      | £100,000  | 2000               | £1,400 | £510                 | £840                    |
      | £0        | 2000               | £1,400 | £560                 | £840                    |
