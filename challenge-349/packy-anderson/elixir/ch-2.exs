#!/usr/bin/env elixir

defmodule PWC do
  def meeting_point([], {_, _}), do: false

  def meeting_point([step | path], {x, y}) do
    {x, y} = case step do
      "U" -> {x, y + 1}
      "D" -> {x, y - 1}
      "R" -> {x + 1, y}
      "L" -> {x - 1, y}
    end
    case {x, y} do
      {0, 0} -> true
      _ -> meeting_point(path, {x, y})
    end
  end

  def meeting_point(path) do
    meeting_point(String.graphemes(path), {0, 0})
  end

  def solution(path) do
    IO.puts("Input: $path = \"#{path}\"")
    IO.puts("Output: #{meeting_point(path)}")
  end
end

IO.puts("Example 1:")
PWC.solution("ULD")

IO.puts("\nExample 2:")
PWC.solution("ULDR")

IO.puts("\nExample 3:")
PWC.solution("UUURRRDDD")

IO.puts("\nExample 4:")
PWC.solution("UURRRDDLLL")

IO.puts("\nExample 5:")
PWC.solution("RRUULLDDRRUU")
