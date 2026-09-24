#!/usr/bin/env elixir

defmodule PWC do
  def is_palindrome(list) when length(list) <= 1, do: true
  def is_palindrome(list) do
    import List
    first(list) == last(list) and
      is_palindrome(list |> tl |> pop_at(-1) |> elem(1))
  end

  def convert_palindrome(str, add) do
    if is_palindrome(str) do
      {add, str}
    else
      {last, str} = List.pop_at(str, -1)
      convert_palindrome(str, add ++ [last])
    end
  end

  def convert_palindrome(str) do
    {add, str} = convert_palindrome(String.codepoints(str), [])
    import Enum
    join(add) <> join(str) <> join(reverse(add))
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{convert_palindrome(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("pinnipeds")

IO.puts("\nExample 2:")
PWC.solution("abcd")

IO.puts("\nExample 3:")
PWC.solution("bananas")

IO.puts("\nExample 4:")
PWC.solution("dissident")

IO.puts("\nExample 5:")
PWC.solution("cailliachs")

IO.puts("\nExample 6:")
PWC.solution("gohangasalamiimalasagnahog")
