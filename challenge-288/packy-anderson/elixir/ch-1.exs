#!/usr/bin/env elixir

defmodule PWC do
  def isPalindrome(num) do
    # convert numerics to Strings, then reverse one of them
    Integer.to_string(num) ==
      Integer.to_string(num) |> String.reverse
  end

  def closestPalindrome(num, distance) do
    cond do
      # is the smaller number at this distance a palindrome?
      isPalindrome(num - distance) ->
        Integer.to_string(num - distance)

      # is the larger number at this distance a palindrome?a
      isPalindrome(num + distance) ->
        Integer.to_string(num + distance)

      # step 1 number futher away
      true ->
        closestPalindrome(num, distance + 1)
    end
  end

  def closestPalindrome(str) do
    String.to_integer(str) |> closestPalindrome(1)
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{closestPalindrome(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("123")

IO.puts("\nExample 2:")
PWC.solution("2")

IO.puts("\nExample 3:")
PWC.solution("1400")

IO.puts("\nExample 4:")
PWC.solution("1001")

IO.puts("\nExample 5: (it doesn't say the input is a POSITIVE int)")
PWC.solution("-1")
