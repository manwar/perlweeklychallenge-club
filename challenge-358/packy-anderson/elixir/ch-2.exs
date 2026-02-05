#!/usr/bin/env elixir

defmodule PWC do
  import Enum
  import String, except: [split: 2]

  @doc """
  Provide a transliteration method, since Elixir doesn't have one
  """
  def translate(s, orig, shifted) do
    charmap = zip_reduce([ orig, shifted ], %{},
      fn [o,s], m -> Map.put(m, o, s) end
    )
    codepoints(s)
    |> map(fn c -> Map.get(charmap, c) end)
    |> join
  end

  def rot_n(s, n) do
    n = rem(n, 26) # 0 <= n < 26
    orig = ?a..?z |> to_list |> to_string |> codepoints
    {s2, s1} = split(orig, n)
    shifted = s1 ++ s2
    translate(s, orig, shifted)
  end

  def solution(s, n) do
    IO.puts("Input: $str = \"#{s}\", $int = #{n}")
    IO.puts("Output: \"#{rot_n(s, n)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("abc", 1)

IO.puts("\nExample 2:")
PWC.solution("xyz", 2)

IO.puts("\nExample 3:")
PWC.solution("abc", 27)

IO.puts("\nExample 4:")
PWC.solution("hello", 5)

IO.puts("\nExample 5:")
PWC.solution("perl", 26)
