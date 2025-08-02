#!/usr/bin/env elixir

defmodule PWC do

  def bAfterA([], seen_b), do: seen_b

  def bAfterA([c | rest], seen_b) do
    cond do
      seen_b && c == "a" -> false
      true               -> bAfterA(rest, seen_b || c == "b")
    end
  end

  def bAfterA(strVal) when is_binary(strVal) do
    bAfterA(String.codepoints(strVal), false)
  end

  def solution(strVal) do
    IO.puts("Input: $str = \"#{strVal}\"")
    IO.puts("Output: " <> to_string(bAfterA(strVal)) )
  end
end

IO.puts("Example 1:")
PWC.solution("aabb")

IO.puts("\nExample 2:")
PWC.solution("abab")

IO.puts("\nExample 3:")
PWC.solution("aaa")

IO.puts("\nExample 4:")
PWC.solution("bbb")
