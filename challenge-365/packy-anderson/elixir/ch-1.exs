#!/usr/bin/env elixir

defmodule PWC do
  import Enum
  import String, except: [to_charlist: 1] # keep Kernel.to_charlist/1

  def alpha_index_digit_sum(str, k) do
    numstr = str
    |> graphemes
    |> map(fn c -> hd(to_charlist(c)) - 96 end)
    |> join
    1..k |> reduce(numstr, fn _, numstr ->
      numstr
      |> graphemes
      |> map(fn n -> to_integer(n) end)
      |> sum
      |> Integer.to_string
    end)
  end

  def solution(str, k) do
    IO.puts("Input: $str = \"#{str}\", $k = #{k}")
    IO.puts("Output: #{alpha_index_digit_sum(str, k)}")
  end
end

IO.puts("Example 1:")
PWC.solution("abc", 1)

IO.puts("\nExample 2:")
PWC.solution("az", 2)

IO.puts("\nExample 3:")
PWC.solution("cat", 1)

IO.puts("\nExample 4:")
PWC.solution("dog", 2)

IO.puts("\nExample 5:")
PWC.solution("perl", 3)

IO.puts("\nExample BigBird:")
PWC.solution("abcdefghijklmnopqrstuvwxyz", 1)
