#!/usr/bin/env elixir

defmodule PWC do
  def nums(n) do
    Enum.map(0..(2 ** n-1), &(
      Integer.to_string(&1, 2) |> String.pad_leading(n, "0")
    ))
  end

  # trivial case: no question marks
  def replace_question_mark(marks, str) when marks == 0, do:
    List.wrap(str)

  # produce all the combinations
  def replace_question_mark(marks, str) do
    Enum.reduce(nums(marks), [], fn bits, output ->
      b = String.graphemes(bits)
      output ++ [ String.split(str, "?")
      |> Enum.zip_with(b ++ [""], fn x, y -> x <> y end)
      |> Enum.join ]
    end)
  end

  def replace_question_mark(str) do
    # how many question marks
    marks = String.graphemes(str)
    |> Enum.filter(fn c -> c == "?" end)
    |> length
    replace_question_mark(marks, str)
  end

  def quote_join(array) do
    Enum.map(array, &("\"#{&1}\"")) |> Enum.join(", ")
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    output = replace_question_mark(str)
    IO.puts("Output: (#{quote_join(output)})")
  end
end

IO.puts("Example 1:")
PWC.solution("01??0")

IO.puts("\nExample 2:")
PWC.solution("101")

IO.puts("\nExample 3:")
PWC.solution("???")

IO.puts("\nExample 4:")
PWC.solution("1?10")

IO.puts("\nExample 5:")
PWC.solution("1?1?0")
