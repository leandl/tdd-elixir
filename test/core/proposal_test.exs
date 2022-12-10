defmodule Core.ProposalTest do
  use ExUnit.Case, async: false

  alias Core.Proposal
  
  test "new/1 will return a proposal" do
    params = %{id: 1, loan_value: 40_000, number_of_monthly_installments: 120}
    proposal = %Proposal{id: 1, loan_value: 40_000, number_of_monthly_installments: 120}

    assert Proposal.new(params) == proposal
  end

  test "valid?/1 loan must be between 30k and 3M" do
    invalid_low_value_proposal  = %Proposal{id: 1, loan_value: 29_999, number_of_monthly_installments: 120}
    invalid_high_value_proposal = %Proposal{id: 1, loan_value: 3_0000_001, number_of_monthly_installments: 120}
    valid_proposal              = %Proposal{id: 1, loan_value: 40_000, number_of_monthly_installments: 120}

    assert Proposal.valid?(invalid_low_value_proposal) == false
    assert Proposal.valid?(invalid_high_value_proposal) == false
    assert Proposal.valid?(valid_proposal) == true
  end

  test "valid?/1 loan must be paid between 24 and 180 months" do
    invalid_smaller_number_of_monthly_installments        = %Proposal{id: 1, loan_value: 40_000, number_of_monthly_installments: 23}
    invalid_bigger_number_of_monthly_installments         = %Proposal{id: 1, loan_value: 40_000, number_of_monthly_installments: 181}
    valid_proposal_minimun_number_of_monthly_installments = %Proposal{id: 1, loan_value: 40_000, number_of_monthly_installments: 24}
    valid_proposal_maximun_number_of_monthly_installments = %Proposal{id: 1, loan_value: 40_000, number_of_monthly_installments: 180}

    assert Proposal.valid?(invalid_smaller_number_of_monthly_installments) == false
    assert Proposal.valid?(invalid_bigger_number_of_monthly_installments) == false
    assert Proposal.valid?(valid_proposal_minimun_number_of_monthly_installments) == true
    assert Proposal.valid?(valid_proposal_maximun_number_of_monthly_installments) == true
  end
end