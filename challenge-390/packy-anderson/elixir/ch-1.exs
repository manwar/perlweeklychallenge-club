#!/usr/bin/env elixir

defmodule PWC do
  @k_notation ~r/((\d+)\[([^\[\]]+)\])/

  def decode_string(str) do
    if Regex.match?(@k_notation, str) do
      [m, k, s] = Regex.run(@k_notation, str,
                            capture: :all_but_first)
      r = String.duplicate(s, String.to_integer(k))
      decode_string(String.replace(str, m, r))
    else
      str
    end
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{decode_string(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("2[3[a]]")

IO.puts("\nExample 2:")
PWC.solution("10[a]")

IO.puts("\nExample 3:")
PWC.solution("a2[b]c3[d]e")

IO.puts("\nExample 4:")
PWC.solution("2[a2[b]c]")

IO.puts("\nExample 5:")
PWC.solution("1[a]2[b3[c]]")
