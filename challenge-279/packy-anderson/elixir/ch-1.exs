#!/usr/bin/env elixir

defmodule PWC do
  def sortLetters(letters, weights) do
    Enum.zip(weights, letters)
    |> Enum.sort_by( &( &1 |> Tuple.to_list |> List.first ))
    |> Enum.map_join("", &( &1 |> Tuple.to_list |> List.last ))
  end

  def solution(letters, weights) do
    IO.puts("Input: @letters = ('" <>
        Enum.join(letters, "', '") <> "')"
    )
    IO.puts("       @weights = (" <>
        Enum.join(weights, ", ") <> ")"
    )
    IO.puts("Output: " <> sortLetters(letters, weights) )
  end
end

IO.puts("Example 1:")
PWC.solution(
  ['R', 'E', 'P', 'L'], [3, 2, 1, 4]
)

IO.puts("\nExample 2:")
PWC.solution(
  ['A', 'U', 'R', 'K'], [2, 4, 1, 3]
)

IO.puts("\nExample 3:")
PWC.solution(
  ['O', 'H', 'Y', 'N', 'P', 'T'], [5, 4, 2, 6, 1, 3]
)

IO.puts("\nExample 4:")
PWC.solution(
  [ 'C', 'd', 'F', 'i', 'l', 'n', 'o', 'o', 's', 'u'],
  [  1,   4,   5,   8,   3,  10,   9,   2,   7,   6]
)
