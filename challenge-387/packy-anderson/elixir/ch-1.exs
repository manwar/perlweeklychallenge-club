#!/usr/bin/env elixir

defmodule PWC do
  def rearrange_binary_string(str, steps \\ []) do
    steps = if not Regex.match?(~r/^1+0+$/, str) do
      str = Regex.replace(~r/01/, str, "10")
      {_, steps} = rearrange_binary_string(str, steps ++ [str])
      steps
    else
      steps
    end
    {length(steps), steps}
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    {count, steps} = rearrange_binary_string(str)
    IO.puts("Output: #{count}")
    if count > 0 do
      IO.puts("")
      Enum.with_index(steps, 1) # add the index
      |> Enum.map(fn {str, i} ->
        IO.puts("Step #{i}: \"#{str}\"")
      end)
    end
  end
end

IO.puts("Example 1:")
PWC.solution("111000")

IO.puts("\nExample 2:")
PWC.solution("00011")

IO.puts("\nExample 3:")
PWC.solution("01011")

IO.puts("\nExample 4:")
PWC.solution("010101")

IO.puts("\nExample 5:")
PWC.solution("00001")
