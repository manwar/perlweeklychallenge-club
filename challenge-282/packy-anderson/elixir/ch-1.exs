#!/usr/bin/env elixir

defmodule PWC do
  def goodInteger(list, count, char \\ "")

  def goodInteger([], count, char) do
    if count == 3 and char != "" do
      "\"" <> String.duplicate(char, count) <> "\""
    else
      "-1"
    end
  end

  def goodInteger([char | rest], count, _) do
    next = List.first(rest)
    if char != next do
      # the character changed!
      if count == 3 do
        "\"" <> String.duplicate(char, count) <> "\""
      else
        # restart the count with new character
        goodInteger(rest, 1)
      end
    else
      # the character is the same
      goodInteger(rest, count + 1, char)
    end
  end

  def goodInteger(int) do
    Integer.to_string(int)
    |> String.graphemes
    |> goodInteger(1)
  end

  def solution(int) do
    IO.puts("Input: $int = #{to_string(int)}")
    IO.puts("Output: " <> goodInteger(int) )
  end
end

IO.puts("Example 1:")
PWC.solution(12344456)

IO.puts("\nExample 2:")
PWC.solution(1233334)

IO.puts("\nExample 3:")
PWC.solution(10020003)
