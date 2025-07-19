#!/usr/bin/env elixir

defmodule PWC do
  def title_capital(str) do
    str
    |> String.split # separated by a SINGLE space
    |> Enum.map(fn w ->
      if String.length(w) > 2,
        do: String.capitalize(w),
      else: String.downcase(w)
    end)
    |> Enum.join(" ")
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{title_capital(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("PERL IS gREAT")

IO.puts("\nExample 2:")
PWC.solution("THE weekly challenge")

IO.puts("\nExample 3:")
PWC.solution("YoU ARE A stAR")
