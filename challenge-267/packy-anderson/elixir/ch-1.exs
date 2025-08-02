# You are given an array of @ints.

# Write a script to find the sign of product of all integers in
# the given array. The sign is 1 if the product is positive,
# -1 if the product is negative and 0 if product is zero.

# Example 1
# Input: @ints = (-1, -2, -3, -4, 3, 2, 1)
# Output: 1
#
# The product -1 x -2 x -3 x -4 x 3 x 2 x 1 => 144 > 0

# Example 2
# Input: @ints = (1, 2, 0, -2, -1)
# Output: 0
#
# The product 1 x 2 x 0 x -2 x -1 => 0

# Example 3
# Input: @ints = (-1, -1, 1, -1, 2)
# Output: -1
#
# The product -1 x -1 x 1 x -1 x 2 => -2 < 0

defmodule PWC do

  def productSign(ints) do
    product = Enum.reduce(ints, &( &1 * &2 ))
    sign = if product == 0, do: 0,
                          else: div(product, abs(product))
    explain = "The product "
            <> Enum.join(ints, " × ")
            <> " => "
            <> to_string(product)
    explain = cond do
                sign > 0 -> explain <> " > 0"
                sign < 0 -> explain <> " < 0"
                true     -> explain
              end
    {sign, explain}
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    {sign, explain} = PWC.productSign(ints)
    IO.puts("Output: " <> to_string(sign) )
    IO.puts("\n" <> explain)
  end
end

IO.puts("Example 1:")
PWC.solution([-1, -2, -3, -4, 3, 2, 1])

IO.puts("")

IO.puts("Example 2:")
PWC.solution([1, 2, 0, -2, -1])

IO.puts("")

IO.puts("Example 3:")
PWC.solution([-1, -1, 1, -1, 2])
