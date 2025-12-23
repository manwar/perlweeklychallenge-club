#!/usr/bin/env elixir

defmodule PWC do
  def binary_prefix([], _, _,_, explain, output),
  do: {explain, Enum.join(output, ", ")}

  def binary_prefix([bit | nums], bitwidth, bits, num,
                    explain, output)
  do
    num     = (num * 2) + bit
    bits    = bits <> to_string(bit)
    padded  = String.pad_leading(bits, bitwidth)
    explain = explain <> "\n#{padded}: #{num}"
    value   = if rem(num,5) == 0, do: "true", else: "false"
    output  = output ++ [ value ]
    binary_prefix(nums, bitwidth, bits, num, explain, output)
  end

  def binary_prefix(nums) do
    binary_prefix(nums, length(nums), "", 0, "", [])
  end

  def solution(nums) do
    IO.puts("Input: @nums = (" <> Enum.join(nums, ", ") <> ")")
    {explain, output} = binary_prefix(nums)
    IO.puts("Output: (#{output})\n")
    IO.puts("Binary numbers formed (decimal values):#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution([0,1,1,0,0,1,0,1,1,1])

IO.puts("\nExample 2:")
PWC.solution([1,0,1,0,1,0])

IO.puts("\nExample 3:")
PWC.solution([0,0,1,0,1])

IO.puts("\nExample 4:")
PWC.solution([1,1,1,1,1])

IO.puts("\nExample 5:")
PWC.solution([1,0,1,1,0,1,0,0,1,1])
