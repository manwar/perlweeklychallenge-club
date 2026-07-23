#!/usr/bin/env elixir

defmodule PWC do
  defp hamiltonian_cycle(n, path, _, square)
  when n == length(path) do
    # we have n numbers in the path
    # is first+last a square? if it is, we're done!
    sum = List.first(path) + List.last(path)
    cond do
      # we found a complete cycle!
      Enum.any?(square, &( &1 == sum )) -> path
      # it doesn't sum to a square, ditch the last in path
      true -> List.delete_at(path, -1)
    end
  end

  defp hamiltonian_cycle(n, path, nums, square) do
    {path, _} = Enum.reduce_while(square, {path, nums},
      fn s, {path, nums} ->
        diff = s - List.last(path)
        if Map.has_key?(nums, diff) do
          # it's a possibility, add it to the path
          path = path ++ [diff]

          # remove diff from nums that are waiting
          nums = Map.delete(nums, diff)

          # call with this proposed path, and all remaining nums
          path = hamiltonian_cycle(n, path, nums, square)

          # we have a full path, so let's return!
          if n == length(path) do
            {:halt, {path, nums}}
          else
            # put diff back on the waiting list
            nums = Map.put(nums, diff, diff)
            # continue with next s
            {:cont, {path, nums}}
          end
        else
          {:cont, {path, nums}} # diff not a num that's waiting
        end
      end)
    if n == length(path) do
      path
    else
      # we didn't find a path, pop off the last
      List.delete_at(path, -1)
    end
  end

  def hamiltonian_cycle(n) do
    # precaclulate squares
    m = :math.sqrt(n + n-1) |> trunc
    square = Enum.map(2..m, &( &1**2 ))
    nums   = Map.new(2..n, &( { &1, &1 } ))
    path   = [ 1 ] # start with 1
    hamiltonian_cycle(n, path, nums, square)
  end

  def pad(i), do: String.pad_leading(Integer.to_string(i), 2)

  def solution(n) do
    IO.puts("Input: $n = #{n}")
    path = hamiltonian_cycle(n)
    if Enum.empty?(path) do
      IO.puts("Output: ()")
      IO.puts("")
      IO.puts("No valid circular list of numbers exists.")
    else
      IO.puts("Output: " <> Enum.join(path, ", "))
      IO.puts("")
      first = hd(path)
      Enum.reduce(tl(path), first, fn next, last ->
        IO.puts("#{pad(last)} + #{pad(next)} = #{pad(last+next)}")
        next
      end)
      last = List.last(path)
      IO.puts("#{pad(last)} + #{pad(first)} = #{pad(last+first)}")
    end
  end
end

IO.puts("Example 1:")
PWC.solution(32)

IO.puts("\nExample 2:")
PWC.solution(15)

IO.puts("\nExample 3:")
PWC.solution(34)
