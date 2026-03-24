#!/usr/bin/env elixir

defmodule PWC do
  def possible(field, max) when field == "??", do: max + 1
  def possible(field, max) do
    if not String.contains?(field, "?") do
      if String.to_integer(field) <= max, do: 1, else: 0
    else
      0..9 |> Enum.count(fn i ->
        String.replace(field, "?", Integer.to_string(i))
        |> String.to_integer <= max
      end)
    end
  end

  def valid_times(time) do
    [hours, minutes] = String.split(time, ":")
    possible(hours, 23) * possible(minutes, 59)
  end

  def solution(time) do
    IO.puts("Input: $time = \"#{time}\"")
    IO.puts("Output: #{valid_times(time)}")
  end
end

IO.puts("Example 1:")
PWC.solution("?2:34")

IO.puts("\nExample 2:")
PWC.solution("?4:?0")

IO.puts("\nExample 3:")
PWC.solution("??:??")

IO.puts("\nExample 4:")
PWC.solution("?3:45")

IO.puts("\nExample 5:")
PWC.solution("2?:15")

IO.puts("\nExample Trivial 1:")
PWC.solution("23:59")

IO.puts("\nExample Trivial 2:")
PWC.solution("25:1?")
