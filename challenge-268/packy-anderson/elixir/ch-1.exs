#!/usr/bin/env elixir

defmodule PWC do
  defp checkNums(magic, [], []) do
    { :ok, magic }
  end

  defp checkNums(magic, [x | rX], [y | rY]) do
    if y - x == magic do
      checkNums(magic, rX, rY)
    else
      { :err, 0 }
    end
  end

  def magicNumber(x, y) do
    xS = Enum.sort(x)
    yS = Enum.sort(y)
    magic = Enum.at(yS, 0) - Enum.at(xS, 0)
    checkNums(magic, xS, yS)
  end

  def solution(x, y) do
    IO.puts("Input: @x = (" <> Enum.join(x, ", ") <> ")")
    IO.puts("       @y = (" <> Enum.join(y, ", ") <> ")")
    case PWC.magicNumber(x, y) do
      {:ok, magic} ->
        IO.puts("Output: #{to_string(magic)}")
        IO.puts("\nThe magic number is #{to_string(magic)}.")
        IO.puts("@x = (" <> Enum.join(x, ", ") <> ")")
        IO.puts("   +  " <> Enum.join(
          Enum.map(x, fn _ -> magic end), "  "
        ))
        IO.puts("@y = (" <> Enum.join(
          Enum.map(x, fn n -> n + magic end), ", "
        ) <> ")")
      {:err, _} ->
        IO.puts('Output: no magic number')
    end
  end
end

IO.puts("Example 1:")
PWC.solution([3, 7, 5], [9, 5, 7])

IO.puts("\nExample 2:")
PWC.solution([1, 2, 1], [5, 4, 4])

IO.puts("\nExample 3:")
PWC.solution([2], [5])

IO.puts("\nExample 4:")
PWC.solution([1, 2], [4, 2])
