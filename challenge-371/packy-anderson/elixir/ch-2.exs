#!/usr/bin/env elixir

defmodule PWC do
  def subsets([]), do: []
  def subsets([i | rest]) do
    list = subsets(rest)
    [[i] | Enum.reduce(list, list, &[[i | &1] | &2])]
  end

  def equilibrium([], results, explain, _),
    do: {results, explain}

  def equilibrium([s | remain], results, explain, count) do
    indices = s |> Enum.map(fn e -> elem(e, 0) end)
    values  = s |> Enum.map(fn e -> elem(e, 1) end)
    i_sum   = indices |> Enum.sum
    v_sum   = values  |> Enum.sum
    {explain, results, count} = if i_sum == v_sum do
      value_list   = values  |> Enum.join(", ")
      plus_values  = values  |> Enum.join(" + ")
      plus_indices = indices |> Enum.join(" + ")
      {
        explain ++ [
          "Subset #{count}: (#{value_list})\n" <>
          "Values: #{plus_values} = #{v_sum}\n" <>
          "Positions: #{plus_indices} = #{i_sum}"
        ],
        results ++ [values],
        count + 1
      }
    else
      {explain, results, count}
    end
    equilibrium(remain, results, explain, count)
  end

  def proper(tuples), do: subsets(tuples)
    |> Enum.filter(fn s ->
      length(s) > 1 and length(s) < length(tuples)
    end)

  def equilibrium(nums) do
    {_, tuples} = Enum.reduce(nums,
      {1, []}, fn n, {i,l} -> {i+1, l ++ [{i,n}]} end
    )
    # only consider PROPER subsets with 2 or more elements
    {results, explain} = equilibrium(proper(tuples), [], [], 1)
    { Enum.join(explain, "\n\n"), results }
  end

  def display_subsets(subsets) when length(subsets)==0, do: "()"
  def display_subsets(subsets) do
    subsets
    |> Enum.map(fn s -> "(" <> Enum.join(s, ", ") <> ")" end)
    |> Enum.join(", ")
  end

  def solution(nums) do
    IO.puts("Input: @nums = (" <> Enum.join(nums, ", ") <> ")")
    {explain, result} = equilibrium(nums)
    IO.puts("Output: #{display_subsets(result)}")
    if String.length(explain) > 0 do
      IO.puts("\n#{explain}")
    end
  end
end

IO.puts("Example 1:")
PWC.solution([2, 1, 4, 3])

IO.puts("\nExample 2:")
PWC.solution([3, 0, 3, 0])

IO.puts("\nExample 3:")
PWC.solution([5, 1, 1, 1])

IO.puts("\nExample 4:")
PWC.solution([3, -1, 4, 2])

IO.puts("\nExample 5:")
PWC.solution([10, 20, 30, 40])
