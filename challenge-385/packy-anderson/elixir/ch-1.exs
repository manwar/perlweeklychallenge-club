#!/usr/bin/env elixir

defmodule PWC do
  def uncommon_words(sentence1, sentence2) do
    sentence1 <> " " <> sentence2 # make two sentences one
    |> String.split           # split on whitespace
    |> Enum.frequencies       # count occurrences of each word
    |> Enum.filter(fn {_, v} -> v == 1 end) # filter for words that happen once
    |> Map.new                # Enum.filter yields list of tuples
    |> Map.keys               # return just the keys
    |> Enum.sort           # sort so the answer's always the same
  end

  def quote_join(array) do
    Enum.map(array, &("\"#{&1}\"")) |> Enum.join(", ")
  end

  def solution(sentence1, sentence2) do
    IO.puts("Input: $sentence1 = \"#{sentence1}\"")
    IO.puts("       $sentence2 = \"#{sentence2}\"")
    IO.puts("Output: (#{quote_join(uncommon_words(sentence1, sentence2))})")
  end
end

IO.puts("Example 1:")
PWC.solution("apple banana apple", "banana orange")

IO.puts("\nExample 2:")
PWC.solution("cat dog", "bird fish")

IO.puts("\nExample 3:")
PWC.solution("the quick brown fox", "the quick")

IO.puts("\nExample 4:")
PWC.solution("hello", "hello")

IO.puts("\nExample 5:")
PWC.solution("blue blue red", "red green green yellow")
