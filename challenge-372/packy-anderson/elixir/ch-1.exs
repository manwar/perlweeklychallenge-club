#!/usr/bin/env elixir

defmodule PWC do
  def rearrange(str) do
    words  = str |> String.split(" ", trim: true)
    spaces = Regex.replace(~r/\S+/, str, "") |> String.length
    w = length(words) - 1
    if w == 0 do
      hd(words) <> String.duplicate(" ", spaces)
    else
      {between, final} = {div(spaces,w), rem(spaces, w)}
      words |> Enum.join(String.duplicate(" ", between))
            |> then(&(&1 <> String.duplicate(" ", final)))
    end
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{rearrange(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("  challenge  ")

IO.puts("\nExample 2:")
PWC.solution("coding  is  fun")

IO.puts("\nExample 3:")
PWC.solution("a b c  d")

IO.puts("\nExample 4:")
PWC.solution("  team      pwc  ")

IO.puts("\nExample 5:")
PWC.solution("   the  weekly  challenge  ")
