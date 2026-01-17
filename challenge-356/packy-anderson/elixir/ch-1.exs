#!/usr/bin/env elixir

defmodule PWC do
  import Integer, only: [is_odd: 1] # needed for is_odd/1
  import Regex, only: [replace: 3]
  import String, only: [slice: 2]

  def kolakoski(int) when int == 1, do: "(1)"

  def kolakoski(int) do
    digit = if is_odd(int) do "1" else "2" end
    int   = int - 1
    seq   = kolakoski(int)
    chars = replace(~r/\D/, seq, "") # get rid of the parens
    if slice(chars, int..int) == "1" do
      seq <> "(#{digit})"
    else
      seq <> "(#{digit}#{digit})"
    end
  end

  def kolakoski_sequence(int) do
    seq   = kolakoski(int)
    chars = replace(~r/\D/, seq, "") |> slice(0..(int-1))
    {
      replace(~r/2/, chars, "") |> String.length, # get rid of 2s
      "#{seq} => #{chars}"
    }
  end

  def solution(int) do
    IO.puts("Input: $int = #{int}")
    {count, explain} = kolakoski_sequence(int)
    IO.puts("Output: #{count}\n\n#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution(4)

IO.puts("\nExample 2:")
PWC.solution(5)

IO.puts("\nExample 3:")
PWC.solution(6)

IO.puts("\nExample 4:")
PWC.solution(7)

IO.puts("\nExample 5:")
PWC.solution(8)
