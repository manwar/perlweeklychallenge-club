#!/usr/bin/env elixir

defmodule PWC do
  def last_visitor([], _, ans, _), do: ans

  def last_visitor([i | ints], seen, ans, x) do
    {seen, ans, x} = if i > 0 do
      {[i] ++ seen, ans, x} # insert at front of @seen
    else
      if x < length(seen) do # if $x < len(@seen)
        # append seen[x] to @ans
        {seen, ans ++ [Enum.at(seen, x)], x+1}
      else
        {seen, ans ++ [-1], x+1} # append -1 to @ans
      end
    end
    last_visitor(ints, seen, ans, x)
  end

  def last_visitor(ints) do
    last_visitor(ints, [], [], 0)
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    out = last_visitor(ints)
    IO.puts("Output: (" <> Enum.join(out, ", ") <> ")")
  end
end

IO.puts("Example 1:")
PWC.solution([5, -1, -1])

IO.puts("\nExample 2:")
PWC.solution([3, 7, -1, -1, -1])

IO.puts("\nExample 3:")
PWC.solution([2, -1, 4, -1, -1])

IO.puts("\nExample 4:")
PWC.solution([10, 20, -1, 30, -1, -1])

IO.puts("\nExample 5:")
PWC.solution([-1, -1, 5, -1])
