#!/usr/bin/env elixir

defmodule PWC do
  def order_characters([], _, seen), do: seen

  def order_characters([str | stack], k, seen) do
    Enum.reduce(0..k-1, seen, fn i, seen ->
      char = String.slice(str, i, 1)
      new  = String.slice(str, 0, i)
          <> String.slice(str, i+1, String.length(str))
          <> char
      if not Map.has_key?(seen, new) do
        order_characters(
          stack ++ [new], k, Map.put(seen, new, 1)
        )
      else
        seen
      end
    end)
  end

  def order_characters(str, k) do
    order_characters([str], k, Map.put(%{}, str, 1))
    |> Map.keys |> Enum.sort |> List.first
  end

  def solution(str, k) do
    IO.puts("Input: $str = \"#{str}\", $k = #{k}")
    IO.puts("Output: \"#{order_characters(str, k)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("dbca", 1)

IO.puts("\nExample 2:")
PWC.solution("geeks", 2)

IO.puts("\nExample 3:")
PWC.solution("cbaed", 3)

IO.puts("\nExample 4:")
PWC.solution("fedcba", 4)

IO.puts("\nExample 5:")
PWC.solution("perl", 1)

IO.puts("\nExample 6:")
PWC.solution("oloolooo", 1)

IO.puts("\nExample 7:")
PWC.solution("oloooolo", 1)
