#!/usr/bin/env elixir

defmodule PWC do
  defp permutations([]), do: [[]]

  defp permutations(list) do
    for head <- list, rest <- permutations(list -- [head]),
      do: [head|rest]
  end

  def secret_santa(n) do
    nums = Range.to_list(1 .. n)
    Enum.reduce(permutations(nums), [], fn perm, valid ->
      is_valid = Enum.reduce_while(0 .. n-1, 1, fn i, _ ->
        if Enum.at(perm, i) == i+1,
          do: {:halt, 0},
          else: {:cont, 1}
      end)
      if is_valid == 1, do: valid ++ [perm], else: valid
    end)
    |> length
  end

  def solution(n) do
    IO.puts("Input: $n = #{n}")
    IO.puts("Output: #{secret_santa(n)}")
  end
end

IO.puts("Example 1:")
PWC.solution(1)

IO.puts("\nExample 2:")
PWC.solution(2)

IO.puts("\nExample 3:")
PWC.solution(3)

IO.puts("\nExample 4:")
PWC.solution(4)

IO.puts("\nExample 5:")
PWC.solution(5)
