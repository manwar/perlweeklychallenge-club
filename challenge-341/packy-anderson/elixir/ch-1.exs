#!/usr/bin/env elixir

defmodule PWC do
  def broken_keys(str, []) do
    # if there are no broken keys,
    # we can type all the words
    String.split(str)
    |> Enum.count
  end

  def broken_keys(str, keys) do
    # build a character class
    {:ok, regex} = Regex.compile(
      "[" <> Enum.join(keys) <> "]", [:caseless]
    )
    # count how many words don't match the class
    String.split(str)
    |> Enum.filter(fn word -> not Regex.match?(regex, word) end)
    |> Enum.count
  end

  def solution(str, keys) do
    keylist = keys
    |> Enum.map(fn c -> "'#{c}'" end)
    |> Enum.join(",")
    IO.puts("Input: $str = '#{str}, @keys = (#{keylist})'")
    IO.puts("Output: #{broken_keys(str, keys)}")
  end
end

IO.puts("Example 1:")
PWC.solution("Hello World", ["d"])

IO.puts("\nExample 2:")
PWC.solution("apple banana cherry", ["a", "e"])

IO.puts("\nExample 3:")
PWC.solution("Coding is fun", [])

IO.puts("\nExample 4:")
PWC.solution("The Weekly Challenge", ["a","b"])

IO.puts("\nExample 5:")
PWC.solution("Perl and Python", ["p"])
