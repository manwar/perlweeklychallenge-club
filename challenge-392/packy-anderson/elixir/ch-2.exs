#!/usr/bin/env elixir

defmodule PWC do
  def common([], _), do: false

  def common([c | rest], bag2) do
    if Map.has_key?(bag2, c), do: true,
    else: common(rest, bag2)
  end

  def common(first, second) do
    bag1 = String.codepoints(first)  |> Enum.frequencies
    bag2 = String.codepoints(second) |> Enum.frequencies
    common(Map.keys(bag1), bag2)
  end

  def wlp(words, i, j) do
    first  = Enum.at(words, i)
    second = Enum.at(words, j)
    if not common(first, second) do
      String.length(first) * String.length(second)
    else
      last = length(words)-2
      cond do
        j <= last -> wlp(words, i, j+1)
        i < last  -> wlp(words, i+1, i+2)
        true      -> 0
      end
    end
  end

  def wlp(words) do
    wlp(Enum.sort_by(words, &{byte_size(&1), &1}, :desc), 0, 1)
  end

  def quote_join(array) do
    Enum.map(array, &("\"#{&1}\"")) |> Enum.join(", ")
  end

  def solution(words) do
    IO.puts("Input: @words = (#{quote_join(words)})")
    IO.puts("Output: #{wlp(words)}")
  end
end

IO.puts("Example 1:")
PWC.solution(["a", "ab", "abc", "d", "de", "def"])

IO.puts("\nExample 2:")
PWC.solution(["a", "aa", "aaa", "aaaa"])

IO.puts("\nExample 3:")
PWC.solution(["meet", "app", "code", "sky", "bold"])

IO.puts("\nExample 4:")
PWC.solution(["a", "ab", "abc", "abcd", "efghi"])

IO.puts("\nExample 5:")
PWC.solution(["xyz", "w", "abcdefg", "hij"])
