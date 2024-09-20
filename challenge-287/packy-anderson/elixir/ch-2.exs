#!/usr/bin/env elixir

defmodule PWC do
  def top() do
    ~r/
      ^
        (?:
          [+-]? \p{N}+ (?: [eE] (?: [+-]? \p{N}+ ) )?
          |
          [+-]? (?: \p{N}+ \. | \p{N}+ \. \p{N}+ | \. \p{N}+ )
          (?: [eE] (?: [+-]? \p{N}+ ) )?
        )
      $
    /ux
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: #{ String.match?(str, top()) }")
  end
end

IO.puts("Example 1:")
PWC.solution("1")

IO.puts("\nExample 2:")
PWC.solution("a")

IO.puts("\nExample 3:")
PWC.solution(".")

IO.puts("\nExample 4:")
PWC.solution("1.2e4.2")

IO.puts("\nExample 5:")
PWC.solution("-1.")

IO.puts("\nExample 6:")
PWC.solution("+1E-8")

IO.puts("\nExample 7:")
PWC.solution(".44")

IO.puts("\nExample 8:")
PWC.solution("-३.१")
