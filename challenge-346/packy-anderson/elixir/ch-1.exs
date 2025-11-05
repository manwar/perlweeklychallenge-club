#!/usr/bin/env elixir

defmodule PWC do
  # we're at the end of the outer loop
  def longest_paren(_, len, found, start, stop, _)
    when start == len and stop == len, do: found

  # we're at the end of the inner loop, next outer loop iteration
  def longest_paren(str, len, found, start, stop, _)
    when start < len and stop == len, do:
    longest_paren(str, len, found, start+1, start+1, 0)

  def longest_paren(str, len, found, start, stop, count) do
    c = String.slice(str, stop, 1)
    substring = String.slice(str, start, stop-start+1)
    count = cond do
      c == "(" -> count + 1
      c == ")" -> count - 1
    end
    cond do
      # unbalanced left paren
      count < 0 ->
        longest_paren(str, len, found, start+1, start+1, 0)

      # if we've reached the end of $str and we're at 0,
      # any valid paren strings we find in subsequent outer loop
      # iterations will be substrings
      count == 0 and stop == len-1 ->
        found ++ [substring]

      # we have exactly as many right parens as we've seen left
      count == 0 ->
        longest_paren(str, len, found ++ [substring],
                      start, stop+1, count)

      # process the next inner loop iteration
      true ->
        longest_paren(str, len, found, start, stop+1, count)
    end
  end

  def longest_paren(str) do
    longest_paren(str, String.length(str), [], 0, 0, 0)
    |> Enum.sort(&(String.length(&1) >= String.length(&2)))
    |> List.first
    |> String.length
  end

  def solution(str) do
    IO.puts("Input: $str = '#{str}'")
    IO.puts("Output: #{longest_paren(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("(()())")

IO.puts("\nExample 2:")
PWC.solution(")()())")

IO.puts("\nExample 3:")
PWC.solution("((()))()(((()")

IO.puts("\nExample 4:")
PWC.solution("))))((()(")

IO.puts("\nExample 5:")
PWC.solution("()(()")
