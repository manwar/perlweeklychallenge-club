#!/usr/bin/env elixir

defmodule PWC do
  defp fmt(num) do
    String.pad_leading(to_string(num), 2)
  end

  def incDec([], x, explain), do:
    {x, Enum.join(explain, "\n")}

  def incDec([op | operations], x, explain) do
    old_x = x
    {x, o} = cond do
      String.contains?(op, "++") ->
        { x + 1, "+" }
      true ->
        { x - 1, "-" }
    end
    incDec(operations, x, explain ++ [
      "Operation \"#{op}\" => #{fmt(old_x)} #{o} 1 => #{fmt(x)}"
    ])
  end

  def incDec(operations) do
    incDec(operations, 0, [])
  end

  def solution(operations) do
    display = "\"" <> Enum.join(operations, "\", \"") <> "\""
    IO.puts("Input: @operations = (#{display})")
    {output, explain} = incDec(operations)
    IO.puts("Output: #{output}\n\n#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution(["--x", "x++", "x++"])

IO.puts("\nExample 2:")
PWC.solution(["x++", "++x", "x++"])

IO.puts("\nExample 3:")
PWC.solution(["x++", "++x", "--x", "x--"])
