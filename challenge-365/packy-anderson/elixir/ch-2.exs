#!/usr/bin/env elixir

defmodule PWC do
  def valid_token(w), do:
    Regex.match?(~r/^(?:\p{Ll}+\-)?\p{Ll}+[!.,]?$/, w)

  def valid_token_count(str) do
    str
    |> String.split
    |> Enum.filter(fn w -> valid_token(w) end)
    |> length
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: #{valid_token_count(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("cat and dog")

IO.puts("\nExample 2:")
PWC.solution("a-b c! d,e")

IO.puts("\nExample 3:")
PWC.solution("hello-world! this is fun")

IO.puts("\nExample 4:")
PWC.solution("ab- cd-ef gh- ij!")

IO.puts("\nExample 5:")
PWC.solution("wow! a-b-c nice.")
