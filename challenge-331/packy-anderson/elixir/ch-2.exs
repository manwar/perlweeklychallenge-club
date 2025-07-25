#!/usr/bin/env elixir

defmodule PWC do
  # womp-womp! nothing matched!
  def buddy_string(source, _, i) when i >= length(source)-1,
    do: "false"

  def buddy_string(source, target, i) do
    # swap the i-th and following positions
    # and re-join the list into a string, then
    # test to see if it matches the target!
    if target == Enum.slide(source, i, i+1) |> Enum.join do
      "true"
    else
      # look starting with the next character
      buddy_string(source, target, i+1)
    end
  end

  def buddy_string(source, target) do
    # put the source characters in a list, and
    # process from the beginning of the list
    buddy_string(String.graphemes(source), target, 0)
  end

  def solution(source, target) do
    IO.puts("Input: $source = \"#{source}\"")
    IO.puts("       $target = \"#{target}\"")
    IO.puts("Output: #{buddy_string(source, target)}")
  end
end

IO.puts("Example 1:")
PWC.solution("fuck", "fcuk")

IO.puts("\nExample 2:")
PWC.solution("love", "love")

IO.puts("\nExample 3:")
PWC.solution("fodo", "food")

IO.puts("\nExample 4:")
PWC.solution("feed", "feed")
