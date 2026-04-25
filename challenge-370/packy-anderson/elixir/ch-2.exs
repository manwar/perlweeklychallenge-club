#!/usr/bin/env elixir

defmodule PWC do
  def divide(string, div) do
    [
      String.slice(string, 0..div-1),
      String.slice(string, div..100)
    ]
  end

  def divide_at(div, source, len, _) when div == len, do: source

  def divide_at(div, source, len, target) do
    # Divide the string X into two non-empty parts
    [s1, s2] = divide(source, div)
    [t1, t2] = divide(target, div)

    # exchange the order of those parts unless one part
    # matches the target
    [s1, s2, t1, t2] = if not (s1 == t1 or s2 == t2) do
      [s2, s1] ++ divide(target, String.length(s2))
    else
      [s1, s2, t1, t2]
    end

    # scramble each of those parts unless all parts
    # match their targets
    {s1, s2} = if not (s1 == t1 and s2 == t2) do
      {
        scramble(s1, String.length(s1), t1),
        scramble(s2, String.length(s2), t2)
      }
    else
      {s1, s2}
    end

    if s1 <> s2 == target do
      s1 <> s2
    else
      divide_at(div+1, source, len, target)
    end
  end

  # If the string consists of only one character,
  # return the string
  def scramble(source, len, _) when len == 1, do: source

  # if the string equals the target we're seeking,
  # return the string
  def scramble(s, _, t) when s == t, do: s

  def scramble(source, len, target) do
    divide_at(1, source, len, target)
  end

  def is_scrambled(source, target) do
    scramble(source, String.length(source), target) == target
  end

  def solution(str1, str2) do
    IO.puts("Input: $str1 = \"#{str1}\", $str2 = \"#{str2}\"")
    IO.puts("Output: #{is_scrambled(str1, str2)}")
  end
end

IO.puts("Example 1:")
PWC.solution("abc", "acb")

IO.puts("\nExample 2:")
PWC.solution("abcd", "cdba")

IO.puts("\nExample 3:")
PWC.solution("hello", "hiiii")

IO.puts("\nExample 4:")
PWC.solution("ateer", "eater")

IO.puts("\nExample 5:")
PWC.solution("abcd", "bdac")
