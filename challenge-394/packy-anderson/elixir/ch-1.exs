#!/usr/bin/env elixir

defmodule PWC do
  def is_alternating(str) do
    Regex.match?(
      ~r/^(?:[a-z]?(?:[A-Z][a-z])+|[A-Z]?(?:[a-z][A-Z])+)$/,
      str
    )
  end

  def no_alt(str, i) do
    Regex.compile!("([A-Z]{#{i}}[a-z]{#{i}}|" <>
                    "[a-z]{#{i}}[A-Z]{#{i}})")
    |> Regex.run(str, [return: :index])
  end

  # approximate perl's substr
  def substr(str, start, replace) do
    len  = String.length(replace)
    head = String.slice(str, 0, start)
    tail = String.slice(str, start+len, String.length(str))
    head <> replace <> tail
  end

  def alternate_case(str, swaps) do
    if is_alternating(str) do
      {length(swaps), swaps}
    else
      i = div(String.length(str), 2)
      {str, swaps} = Enum.reduce_while(i..1//-1, {str, swaps},
      fn j, {str, swaps} ->
        m = no_alt(str, j)
        if m do
          {from, chars} = hd(m) # de-listify and unpack tuple
          start = from + div(chars, 2) - 1
          flip  = String.slice(str, start, 2)
          str   = substr(str, start, String.reverse(flip))
          {:halt, {str, swaps ++ [str]}}
        else
          {:cont, {str, swaps}}
        end
      end)
      if is_alternating(str) do
        {length(swaps), swaps}
      else
        alternate_case(str, swaps)
      end
    end
  end

  def alternate_case(str) do
    alternate_case(str, [])
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    {count, swaps} = alternate_case(str)
    IO.puts("Output: #{count}")
    if length(swaps) > 0 do
      IO.puts("")
      Enum.zip(1..length(swaps), swaps)
      |> Enum.each(fn {c, s} ->
        IO.puts("Swap #{c}: \"#{s}\"")
      end)
    end
  end
end

IO.puts("Example 1:")
PWC.solution("aAbB")

IO.puts("\nExample 2:")
PWC.solution("AAbb")

IO.puts("\nExample 3:")
PWC.solution("AAAbbb")

IO.puts("\nExample 4:")
PWC.solution("aABb")

IO.puts("\nExample 5:")
PWC.solution("bBBAaa")
