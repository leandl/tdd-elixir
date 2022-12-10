defmodule Core.ValidatorTest do
  use ExUnit.Case, async: false

  alias Core.Validator

  test "new/1 creates a validator" do
    data = ""
    validator = %Validator{data: ""}

    assert Validator.new(data) == validator
  end

  test "validate/2 executes the validation function and return the validator" do
    data = 10
    is_bigger_than_10 = fn(n) -> n > 10 end
    is_even = fn(n) -> rem(n, 2) == 0 end

    validator         = %Validator{data: data}
    invalid_validator = %Validator{data: data, is_valid: false}

    assert Validator.validate(validator, is_bigger_than_10) == invalid_validator
    assert Validator.validate(invalid_validator, is_even) == invalid_validator
  end
end