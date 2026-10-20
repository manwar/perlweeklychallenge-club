#!/usr/bin/env elixir

defmodule PWC do
  def is_trionic(arr) do
    {mode, p, q} = Enum.reduce_while(
      1 .. length(arr)-1,
      {0, nil, nil},
      fn i, {mode, p, q} ->
        curr = Enum.at(arr, i)
        last = Enum.at(arr, i-1)
        {mode, p, q} = cond do
          last == curr -> {:halt, nil, nil} # no strict inc or dec
          mode == 0 -> cond do
              # proceed to strictly decreasing
              last > curr  -> {1, i-1, q} # set p
              true         -> {mode, p, q} # stay in this state
            end
          mode == 1 -> cond do
              # proceed to strictly increasing
              last > curr  -> {2, p, i} # set q
              true         -> {mode, p, q} # stay in this state
            end
          mode == 2 -> cond do
              last >= curr -> {:halt, nil, nil} # no strict inc
              true         -> {mode, p, q} # stay in this state
            end
          # catch all for errors
          true -> {:halt, nil, nil}
        end
        if mode == :halt do
          {:halt, {:false, nil, nil}}
        else
          {:cont, {mode, p, q}}
        end
      end
    ) # end Enum.reduce_while
    if mode != 2 do
      {"false", nil, nil}
    else
      {"true", p, q}
    end
  end

  def quote_join(array) do
    Enum.map(array, &("\"#{&1}\"")) |> Enum.join(", ")
  end

  def solution(arr) do
    IO.puts("Input: @arr = (" <> Enum.join(arr, ", ") <> ")")
    {result, p, q} = is_trionic(arr)
    IO.puts("Output: #{result}")
    if result == "true" do
      IO.puts("\nChoose p = #{p} and q = #{q}")
    end
  end
end

IO.puts("Example 1:")
PWC.solution([1, 3, 5, 4, 2, 6, 8])

IO.puts("\nExample 2:")
PWC.solution([1, 4, 4, 2, 1, 3, 5])

IO.puts("\nExample 3:")
PWC.solution([2, 10, 3, 1, 9])

IO.puts("\nExample 4:")
PWC.solution([1, 2, 3, 4, 3, 2, 1])

IO.puts("\nExample 5:")
PWC.solution([1, 3, 6, 4, 2, 7, 8, 4])
