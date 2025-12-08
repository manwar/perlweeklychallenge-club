#!/usr/bin/env elixir

defmodule PWC do
  def is_same_length(a, b) do
    a |> Integer.to_string |> String.length ==
    b |> Integer.to_string |> String.length
  end

  def is_pair(a, b) do
    a |> Integer.to_string |> String.codepoints |> Enum.sort ==
    b |> Integer.to_string |> String.codepoints |> Enum.sort
  end

  def has_shuffle_pair(a, m, count, k) do
    b = a * k
    if not is_same_length(a, b) do
      0 # stop processing a if b has more digits than a
    else
      if not is_pair(a, b) do
        # go to the next k if a & b aren't combinations
        # of the same digits
        has_shuffle_pair(a, m, count, k+1)
      else
        # it's a shuffle pair, count it
        count = count + 1
        if count >= m do
          1 # abort searching if we found the min count of pairs
        else
          has_shuffle_pair(a, m, count, k+1)
        end
      end
    end
  end

  def has_shuffle_pair(a, m) do
    has_shuffle_pair(a, m, 0, 2)
  end

  def shuffle_pairs(from, to, count) do
    stream = from .. to
    |> Task.async_stream(
      fn i -> has_shuffle_pair(i, count) end, ordered: false
    )
    Enum.sum_by(stream, fn {:ok, num} -> num end)
  end

  def solution(from, to, count) do
    IO.puts("Input: $from = #{from}, $to = #{to}, " <>
            "$count = #{count}")
    IO.puts("Output: #{shuffle_pairs(from, to, count)}")
  end
end

IO.puts("Example 1:")
PWC.solution(1, 1000, 1)

IO.puts("\nExample 2:")
PWC.solution(1500, 2500, 1)

IO.puts("\nExample 3:")
PWC.solution(1_000_000, 1_500_000, 5)

IO.puts("\nExample 4:")
PWC.solution(13_427_000, 14_100_000, 2)

IO.puts("\nExample 5:")
PWC.solution(1030, 1130, 1)
