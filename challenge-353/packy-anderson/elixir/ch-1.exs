#!/usr/bin/env elixir

defmodule PWC do
  def word_count(sentence) do
    sentence |> String.split |> length
  end

  def max_words(sentences) do
    sentences |> Enum.map(&word_count/1) |> Enum.max
  end

  def solution(sentences) do
    joined = sentences
    |> Enum.map(fn s -> "\"#{s}\"" end)
    |> Enum.join(", ")
    IO.puts("Input: @sentences = (#{joined})")
    IO.puts("Output: #{max_words(sentences)}")
  end
end

IO.puts("Example 1:")
PWC.solution(["Hello world", "This is a test", "Perl is great"])

IO.puts("\nExample 2:")
PWC.solution(["Single"])

IO.puts("\nExample 3:")
PWC.solution(["Short", "This song's just six words long",
              "A B C", "Just four words here"])

IO.puts("\nExample 4:")
PWC.solution(["One", "Two parts", "Three part phrase", ""])

IO.puts("\nExample 5:")
PWC.solution(["The quick brown fox jumps over the lazy dog", "A",
              "She sells seashells by the seashore",
              "To be or not to be that is the question"])
