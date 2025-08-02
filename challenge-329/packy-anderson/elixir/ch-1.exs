#!/usr/bin/env elixir

defmodule PWC do
  defp find_distinct(int, {seen, output}) do
    {int,
      if not MapSet.member?(seen, int) do
        # add int to seen and output
        {MapSet.put(seen, int), output ++ [int]}
      else
        {seen, output}
      end
    }
  end

  def counter_integers(str) do
    # replace lower case letters with space, then
    # get rid of leading and trailing space, then
    # split on whitespace, then
    # build return array of distinct values
    {_, {_, output}}
      =  Regex.replace(~r/\p{L}+/, str, " ")
      |> String.trim
      |> String.split
      |> Enum.map_reduce({MapSet.new([]), []}, &find_distinct/2)

    output
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: " <> Enum.join(counter_integers(str), ", "))
  end
end

IO.puts("Example 1:")
PWC.solution("the1weekly2challenge2")

IO.puts("\nExample 2:")
PWC.solution("go21od1lu5c7k")

IO.puts("\nExample 3:")
PWC.solution("4p3e2r1l")
