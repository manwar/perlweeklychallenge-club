#!/usr/bin/env elixir

defmodule PWC do
  def sortString(str) do
    str
    |> String.split
    |> Enum.map(fn(w) ->
         [_, word, order] = Regex.run(~r/(\D+)(\d+)/, w)
         %{order: order, word: word}
       end)
    |> Enum.sort_by( &( Integer.parse(&1[:order]) ) )
    |> Enum.map_join(" ", &( &1[:word] ))
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"" <> sortString(str) <> "\"")
  end
end

IO.puts("Example 1:")
PWC.solution("and2 Raku3 cousins5 Perl1 are4")

IO.puts("\nExample 2:")
PWC.solution("guest6 Python1 most4 the3 popular5 is2 language7")

IO.puts("\nExample 3:")
PWC.solution("Challenge3 The1 Weekly2")

IO.puts("\nExample 3:")
PWC.solution("The1 brown9 dog10 fox4 jumped5 lazy8 over6 quick2 red3 the7")
