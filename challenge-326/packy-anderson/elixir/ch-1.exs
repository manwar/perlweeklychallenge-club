#!/usr/bin/env elixir

defmodule PWC do

  def solution(dateStr) do
    IO.puts("Input: $date = '#{dateStr}'")
    day_of_year = Date.from_iso8601!(dateStr) |> Date.day_of_year
    IO.puts("Output: #{day_of_year}")
  end
end

IO.puts("Example 1:")
PWC.solution("2025-02-02")

IO.puts("\nExample 2:")
PWC.solution("2025-04-10")

IO.puts("\nExample 3:")
PWC.solution("2025-09-07")
