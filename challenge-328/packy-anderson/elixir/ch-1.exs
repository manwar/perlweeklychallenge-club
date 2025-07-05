#!/usr/bin/env elixir

defmodule PWC do
  def replace_all_question(str) do
    match = Regex.named_captures(
      ~r/(?<before>.)\?+(?<after>.)/,
      str
    )
    if match do
      # since we matched something, let's replace the first ?
      # with a character that won't produce a consecutive
      # repeating character
      replace = ?a..?z |> Enum.take_random(1) |> List.to_string
      str = Regex.replace(~r/\?/, str, replace, global: false)
      # recursively call this function to replace any remaining ?s
      replace_all_question(str)
    else
      # return the unmodified string if there are no ? characters
      str
    end
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{replace_all_question(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("a?z")

IO.puts("\nExample 2:")
PWC.solution("pe?k")

IO.puts("\nExample 3:")
PWC.solution("gra?te")

IO.puts("\nExample 4:")
PWC.solution("so?c?r")

IO.puts("\nExample 5:")
PWC.solution("mi??i??i??i")

IO.puts("\nExample 6:")
PWC.solution("i??????????????????n")
