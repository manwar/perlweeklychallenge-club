#!/usr/bin/env elixir

defmodule PWC do
  def orderGame(ints, explain, loop) when length(ints) == 1 do
    { List.first(ints), Enum.join(explain, "\n") }
  end

  def orderGame(ints, explain, loop) do
    pairs = Enum.chunk_every(ints, 2)
    explain = explain ++ [ "Operation #{loop}:", "" ]
    acc = %{ flip: 1, explain: explain }
    { newints, acc } = Enum.map_reduce(pairs, acc, fn x, acc ->
      a = List.first(x)
      b = List.last(x)
      { val, func } = if acc[:flip] == 1 do # min
        { min(a, b), "min" }
      else # max
        { max(a, b), "max" }
      end
      {
        val,
        acc
        |> Map.put(:explain, acc[:explain] ++
           [ "    #{func}(#{a}, #{b}) = #{val}" ])
        |> Map.put(:flip, acc[:flip] * -1)
      }
    end)
    acc = acc |> Map.put(:explain, acc[:explain] ++ [ "" ])
    orderGame(newints, acc[:explain], loop+1)
  end

  def orderGame(ints) do
    orderGame(ints, [], 1)
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    {output, explain} = orderGame(ints)
    IO.puts("Output: #{output}\n\n#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution([2, 1, 4, 5, 6, 3, 0, 2])

IO.puts("\nExample 2:")
PWC.solution([0, 5, 3, 2])

IO.puts("\nExample 3:")
PWC.solution([9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8])
