#!/usr/bin/env elixir

defmodule PWC do
  def largest_interval(int) do
    integers =
      1..int
      |> Enum.filter(&(!(Integer.to_string(&1) =~ ~r/(.).*\1/)))

    diffs =
      2..(length(integers) - 1)
      |> Enum.reduce(%{}, fn i, diffs ->
        {last, cur} =
          {Enum.at(integers, i - 1), Enum.at(integers, i)}

        d = cur - last

        put_in(
          diffs[d],
          (diffs[d] || []) ++ ["#{last} and #{cur}"]
        )
      end)

    largest = diffs |> Map.keys() |> Enum.max()
    {largest, Map.get(diffs, largest)}
  end

  def solution(int) do
    IO.puts("Input: $int = #{int}")
    {interval, list} = largest_interval(int)
    IO.puts("Output: #{interval}\n\nBiggest jump between:")
    IO.puts(" • " <> Enum.join(list, "\n • "))
  end
end

IO.puts("Example 1")
PWC.solution(20)

IO.puts("\nExample 2")
PWC.solution(110)

IO.puts("\nExample 3")
PWC.solution(500)

IO.puts("\nExample 4")
PWC.solution(2026)

IO.puts("\nExample 5")
PWC.solution(10000)
