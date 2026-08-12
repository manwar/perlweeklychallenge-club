#!/usr/bin/env elixir

defmodule PWC do
  @pat ~r/(?<int>\d*)\.(?<nr>\d*)?(?:\((?<rep>\d*)\))?/

  def int(val) when is_integer(val), do: val
  def int(val), do: String.to_integer(val)

  def rational_to_fraction(rat) do
    %{"int" => int, "nr" => nr, "rep" => rep}
      = Regex.named_captures(@pat, rat)
    nr    = if nr != "",  do: nr,  else: 0 # no non-repeating digits
    rep   = if rep != "", do: rep, else: 0 # no repeating digits
    pow1  = if nr != 0,  do: 10 ** String.length(nr),    else: 1
    pow2  = if rep != 0, do: 10 ** String.length(rep)-1, else: 1
    int   = int(int) # convert strings to integers
    nr    = int(nr)
    rep   = int(rep)
    num   = (int * pow1 + nr) * pow2 + rep
    denom = pow2 * pow1
    d     = Integer.gcd(num, denom)
    { div(num, d), div(denom, d) }
  end

  def rational_equal(rat1, rat2) do
    {n1, d1} = rational_to_fraction(rat1)
    {n2, d2} = rational_to_fraction(rat2)
    len = Enum.max([String.length(rat1), String.length(rat2)])
    rat1 = String.pad_leading(rat1, len)
    rat2 = String.pad_leading(rat2, len)
    {
      (if n1 == n2 and d1 == d2, do: "true", else: "false"),
      "#{rat1} is #{n1}/#{d1}\n#{rat2} is #{n2}/#{d2}"
    }
  end

  def solution(rat1, rat2) do
    IO.puts("Input: $rat1 = \"#{rat1}\"")
    IO.puts("       $rat2 = \"#{rat2}\"")
    {output, explain} = rational_equal(rat1, rat2)
    IO.puts("Output: #{output}\n\n#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution("0.(12)", "0.(121)")

IO.puts("\nExample 2:")
PWC.solution("0.1(23)", "0.12(32)")

IO.puts("\nExample 3:")
PWC.solution("0.1(234)", "0.12(342)")

IO.puts("\nExample 4:")
PWC.solution("12.99(99)", "13.")

IO.puts("\nExample 5:")
PWC.solution("0.(123)", "0.1(231)")
