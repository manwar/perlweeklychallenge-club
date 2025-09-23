#!/usr/bin/env elixir

defmodule PWC do
  def ascending(list) when is_list(list) and length(list) == 1,
    do: "true"

  def ascending([head | list]) do
    if head < List.first(list) do
      ascending(list)
    else
      "false"
    end
  end

  def ascending_num(str) do
     Regex.scan(~r/\d+/, str, capture: :first)
     |> List.flatten
     |> Enum.map(fn n -> String.to_integer(n) end)
     |> ascending
  end

  def solution(str) do
    IO.puts("Input: $str = '#{str}'")
    IO.puts("Output: #{ascending_num(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("The cat has 3 kittens 7 toys 10 beds")

IO.puts("\nExample 2:")
PWC.solution("Alice bought 5 apples 2 oranges 9 bananas")

IO.puts("\nExample 3:")
PWC.solution("I ran 1 mile 2 days 3 weeks 4 months")

IO.puts("\nExample 4:")
PWC.solution("Bob has 10 cars 10 bikes")

IO.puts("\nExample 5:")
PWC.solution("Zero is 0 one is 1 two is 2")
