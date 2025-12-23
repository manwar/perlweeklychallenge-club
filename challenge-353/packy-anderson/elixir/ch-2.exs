#!/usr/bin/env elixir

defmodule PWC do
  @good_names ["electronics", "grocery", "pharmacy", "restaurant"]

  def check_coupon([code, name, status]) do
    cond do
      status == "true" and
      Enum.any?(@good_names, fn n -> n == name end) and
      Regex.match?(~r/^[a-zA-Z0-9_]+$/, code) -> "true"
      true -> "false"
    end
  end

  def validate_coupon(%{codes: codes, names: names,
                        status: status}) do
    Enum.zip_with([codes, names, status], &check_coupon/1)
  end

  def quoted_list(items) do
    items |> Enum.map(fn s -> "\"#{s}\"" end) |> Enum.join(", ")
  end

  def solution(%{codes: codes, names: names, status: status}) do
    IO.puts("Input: @codes  = (#{quoted_list(codes)})")
    IO.puts("       @names  = (#{quoted_list(names)})")
    IO.puts("       @status = (#{quoted_list(status)})")
    output = validate_coupon(%{codes: codes, names: names, status: status})
    |> Enum.join(", ")
    IO.puts("Output: (#{output})")
  end
end

IO.puts("Example 1:")
PWC.solution(%{
  codes:  ["A123", "B_456", "C789", "D@1", "E123"],
  names:  ["electronics", "restaurant", "electronics",
           "pharmacy", "grocery"],
  status: ["true", "false", "true", "true", "true"]
})

IO.puts("\nExample 2:")
PWC.solution(%{
  codes:  ["Z_9", "AB_12", "G01", "X99", "test"],
  names:  ["pharmacy", "electronics", "grocery",
           "electronics", "unknown"],
  status: ["true", "true", "false", "true", "true"]
})

IO.puts("\nExample 3:")
PWC.solution(%{
  codes:  ["_123", "123", "", "Coupon_A", "Alpha"],
  names:  ["restaurant", "electronics", "electronics",
           "pharmacy", "grocery"],
  status: ["true", "true", "false", "true", "true"]
})

IO.puts("\nExample 4:")
PWC.solution(%{
  codes:  ["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"],
  names:  ["electronics", "electronics", "grocery", "grocery"],
  status: ["true", "true", "true", "true"]
})

IO.puts("\nExample 5:")
PWC.solution(%{
  codes:  ["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"],
  names:  ["restaurant", "electronics", "grocery", "pharmacy",
           "electronics"],
  status: ["true", "true", "true", "true", "false"]
})
