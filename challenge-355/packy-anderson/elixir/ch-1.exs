#!/usr/bin/env elixir

defmodule PWC do
  def thousand_separator(int) do
    int
    |> Integer.digits # convert integer into digits
    |> Enum.reverse   # reverse the digits
    |> Enum.chunk_every(3) # return a sequence of 3 element lists
    # convert [[1, 2, 3], [4, 5]] to ["123", "45"]
    |> Enum.map(fn l -> Enum.join(l,"") end)
    |> Enum.join(",") # join the sequence on commas
    |> String.reverse # reverse the whole string
  end

  def solution(int) do
    IO.puts("Input: $int = #{int}")
    IO.puts("Output: \"#{thousand_separator(int)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution(123)

IO.puts("\nExample 2:")
PWC.solution(1234)

IO.puts("\nExample 3:")
PWC.solution(1000000)

IO.puts("\nExample 4:")
PWC.solution(1)

IO.puts("\nExample 5:")
PWC.solution(12345)
