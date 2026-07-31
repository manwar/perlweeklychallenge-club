#!/usr/bin/env elixir

defmodule PWC do
  @chars  Enum.to_list(?0..?9) ++
          Enum.to_list(?A..?Z) ++
          Enum.to_list(?a..?z) ++
          [ ?+, ?/ ] |> Enum.map(&( <<&1 :: utf8>> ))

  def base_n(num, base) do
    Enum.reduce_while(0..64, [], fn p, powers ->
      pow = Integer.pow(base, p)
      if pow < num do
        {:cont, [pow] ++ powers}
      else
        {:halt, powers}
      end
    end)
    |> Enum.reduce({num, ""}, fn pow, {num, result} ->
      { d, num } = { div(num,pow), rem(num, pow) }
      { num, result <> Enum.at(@chars, d) }
    end)
    |> then( &( elem(&1, 1) ) )
  end

  def solution(num, base) do
    IO.puts("Input: $num = #{num}, $base = #{base}")
    IO.puts("Output: #{base_n(num, base)}")
  end
end

IO.puts("Example 1:")
PWC.solution(42, 2)

IO.puts("\nExample 2:")
PWC.solution(15642094, 16)

IO.puts("\nExample 3:")
PWC.solution(493, 8)

IO.puts("\nExample 4:")
PWC.solution(2228519, 36)

IO.puts("\nExample 5:")
PWC.solution(123456789, 64)
