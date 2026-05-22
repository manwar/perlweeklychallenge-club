#!/usr/bin/env elixir

defmodule PWC do
  def max_same(str) do
    digits = String.graphemes(str)
    current = hd(digits)
    { largest, _ } = tl(digits) |> Enum.reduce(
      { String.to_integer(current), current },
      fn digit, { largest, current } ->
        current = if String.starts_with?(current, digit), do:
          current <> digit, else: digit
        { max( String.to_integer(current), largest), current }
      end
    )
    largest
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: #{max_same(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("6777133339")

IO.puts("\nExample 2:")
PWC.solution("1200034")

IO.puts("\nExample 3:")
PWC.solution("44221155")

IO.puts("\nExample 4:")
PWC.solution("88888")

IO.puts("\nExample 5:")
PWC.solution("11122233")
