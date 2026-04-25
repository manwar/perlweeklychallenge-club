#!/usr/bin/env elixir

defmodule PWC do
  def popular(paragraph, banned) do
    banned = banned |> Enum.frequencies
    # remove punctuation
    Regex.replace(~r/[^a-zA-Z\s]/, paragraph, " ")
    |> String.downcase # make lowercase
    |> String.split(" ", trim: true) # split on whitespace
     # filter out banned words
    |> Enum.filter(fn w -> ! Map.has_key?(banned, w) end)
    |> Enum.frequencies # count remaining words
    |> Enum.max_by(fn {_k, v} -> v end) # find maximum value
    |> elem(0) # return key of tuple
  end

  def solution(paragraph, banned) do
    IO.puts("Input: $paragraph = \"#{paragraph}\"")
    banned_list = Enum.map(banned, fn w -> "\"#{w}\"" end)
               |> Enum.join(", ")
    IO.puts("       @banned = (#{banned_list})")
    IO.puts("Output: #{popular(paragraph, banned)}")
  end
end

IO.puts("Example 1:")
PWC.solution("Bob hit a ball, the hit BALL flew far after it was hit.", ["hit"])

IO.puts("\nExample 2:")
PWC.solution("Apple? apple! Apple, pear, orange, pear, apple, orange.", ["apple", "pear"])

IO.puts("\nExample 3:")
PWC.solution("A. a, a! A. B. b. b.", ["b"])

IO.puts("\nExample 4:")
PWC.solution("Ball.ball,ball:apple!apple.banana", ["ball"])

IO.puts("\nExample 5:")
PWC.solution("The dog chased the cat, but the dog was faster than the cat.", ["the", "dog"])
