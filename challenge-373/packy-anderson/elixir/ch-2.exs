#!/usr/bin/env elixir

defmodule PWC do
  def divmod(x,y), do: { div(x,y), rem(x, y) }

  def shift_first(list, c, shifted \\ [])
  def shift_first(list, c, shifted) when c == 0, do:
    {list, shifted}
  def shift_first([e | rest], c, shifted) do
    shift_first(rest, c-1, shifted ++ [e])
  end

  def build_result([], _, _, result), do: result
  def build_result(list, c, r, result) do
    {list, a} = shift_first(list, c)
    {list, a} = if r > 0 do
      shift_first(list, 1, a)
    else
      {list, a}
    end
    build_result(list, c, r-1, result ++ [a])
  end

  def list_div(list, n) when length(list) < n, do: -1
  def list_div(list, n) do
    {c, r} = divmod(length(list), n)
    build_result(list, c, r, [])
  end

  def int_join(list), do:
    "(" <> Enum.join(list, ",") <> ")"

  def solution(list, n) do
    IO.puts("Input: @list = (" <> Enum.join(list, ", ") <>
            "), $n = #{n}")
    result = list_div(list, n)
    joined = if result == -1 do
      "-1"
    else
      "(" <> Enum.join(
        Enum.map(result, fn a -> int_join(a) end),
        ", "
      ) <> ")"
    end
    IO.puts("Output: #{joined}")
  end
end

IO.puts("Example 1:")
PWC.solution([1,2,3,4,5], 2)

IO.puts("\nExample 2:")
PWC.solution([1,2,3,4,5,6], 3)

IO.puts("\nExample 3:")
PWC.solution([1,2,3], 2)

IO.puts("\nExample 4:")
PWC.solution([1,2,3,4,5,6,7,8,9,10], 5)

IO.puts("\nExample 5:")
PWC.solution([1,2,3], 4)

IO.puts("\nExample 6:")
PWC.solution([72,57,89,55,36,84,10,95,99,35], 7)
