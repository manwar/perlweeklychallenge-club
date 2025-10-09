#!/usr/bin/env elixir

defmodule PWC do
  def my_zip([], [], str), do: str

  def my_zip([a], [], str), do: str <> a

  def my_zip([a | longer], [b | shorter], str) do
    str = str <> a <> b
    my_zip(longer, shorter, str)
  end

  def balance_str(str) do
    letters = String.graphemes(str)
      |> Enum.filter(fn c -> c =~ ~r/[a-z]/ end)
      |> Enum.sort
    numbers = String.graphemes(str)
      |> Enum.filter(fn c -> c =~ ~r/\d/ end)
      |> Enum.sort

    numlen = length(numbers)
    letlen = length(letters)

    cond do
      abs(numlen - letlen) > 1 ->
        ""
      letlen > numlen ->
        my_zip(letters, numbers, "")
      true ->
        my_zip(numbers, letters, "")
    end
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{balance_str(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("a0b1c2")

IO.puts("\nExample 2:")
PWC.solution("abc12")

IO.puts("\nExample 3:")
PWC.solution("0a2b1c3")

IO.puts("\nExample 4:")
PWC.solution("1a23")

IO.puts("\nExample 5:")
PWC.solution("ab123")
