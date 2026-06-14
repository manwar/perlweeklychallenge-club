#!/usr/bin/env elixir

defmodule PWC do
  def prefix_suffix(array) do
    Enum.reduce(0..length(array)-2, {0, ""},
    fn i, {count, explain} ->
      Enum.reduce(i+1..length(array)-1, {count, explain},
      fn j, {count, explain} ->
        istr = Enum.at(array, i)
        jstr = Enum.at(array, j)
        cond do
          String.starts_with?(jstr, istr) &&
          String.ends_with?(jstr, istr) ->
            {
              count + 1,
              explain <> "\n$array[#{i}], $array[#{j}]: "
                      <> "\"#{istr}\" is a prefix and suffix "
                      <> "of \"#{jstr}\""
            }
          true -> {count, explain}
        end
      end)
    end)
  end

  def quote_join(array) do
    Enum.map(array, &("\"#{&1}\"")) |> Enum.join(", ")
  end

  def solution(array) do
    IO.puts("Input: @array = (#{quote_join(array)})")
    {count, explain} = prefix_suffix(array)
    IO.puts("Output: #{count}")
    if count > 0, do: IO.puts(explain)
  end
end

IO.puts("Example 1:")
PWC.solution(["a", "aba", "ababa", "aa"])

IO.puts("\nExample 2:")
PWC.solution(["pa", "papa", "ma", "mama"])

IO.puts("\nExample 3:")
PWC.solution(["abao", "ab"])

IO.puts("\nExample 4:")
PWC.solution(["abab", "abab"])

IO.puts("\nExample 5:")
PWC.solution(["ab", "abab", "ababab"])

IO.puts("\nExample 6:")
PWC.solution(["abc", "def", "ghij"])
