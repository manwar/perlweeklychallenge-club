#!/usr/bin/env elixir

defmodule PWC do
  def bigger(str, char) do
    char = Regex.compile!(char)
    indices = Regex.scan(char, str, return: :index)
    if length(indices) == 0 do
      str # doesn't occur
    else
      len = String.length(str)
      indices
      |> Enum.map(fn e ->
           i = elem(hd(e), 0)
           String.slice(str, 0, i) <> String.slice(str, i+1, len)
         end)
      |> Enum.max
    end
  end

  def solution(str, char) do
    IO.puts("Input: $str = \"#{str}\", $char = \"#{char}\"")
    IO.puts("Output:  \"#{bigger(str, char)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("15456", "5")

IO.puts("\nExample 2:")
PWC.solution("7332", "3")

IO.puts("\nExample 3:")
PWC.solution("2231", "2")

IO.puts("\nExample 4:")
PWC.solution("543251", "5")

IO.puts("\nExample 5:")
PWC.solution("1921", "1")

IO.puts("\nExample trivial 1:")
PWC.solution("12345", "6")

IO.puts("\nExample trivial 2:")
PWC.solution("12345", "1")
