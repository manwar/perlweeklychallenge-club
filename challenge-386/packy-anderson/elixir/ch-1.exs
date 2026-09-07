#!/usr/bin/env elixir

defmodule PWC do
  # map chars => values like 'A' => 10, 'a' => 37
  @chars Enum.to_list(?0..?9) ++
         Enum.to_list(?A..?Z) ++
         Enum.to_list(?a..?z) ++
         [ ?+, ?/ ] |> Enum.map(&( <<&1 :: utf8>> )) |>
         Enum.zip(Range.to_list(0..63)) |> Map.new

  def reverse_base(num, base) do
    num
    # break the number into digits
    |> String.codepoints
    # map character to numeric equivalent
    |> Enum.map(fn c -> Map.get(@chars, c) end)
    # reverese the string so place -> power
    |> Enum.reverse
    |> Enum.reduce({0, 0}, fn val, {pow, sum} ->
      { pow+1, (base ** pow * val) + sum } # multiply by power
    end)
    |> elem(1) # Enum.reduce returns {pow, sum}
  end

  def solution(num, base) do
    IO.puts("Input: $num = \"#{num}\", $base = #{base}")
    IO.puts("Output: #{reverse_base(num, base)}")
  end
end

IO.puts("Example 1:")
PWC.solution("101010", 2)

IO.puts("\nExample 2:")
PWC.solution("EEADEE", 16)

IO.puts("\nExample 3:")
PWC.solution("755", 8)

IO.puts("\nExample 4:")
PWC.solution("1BRJB", 36)

IO.puts("\nExample 5:")
PWC.solution("7MyqL", 64)
