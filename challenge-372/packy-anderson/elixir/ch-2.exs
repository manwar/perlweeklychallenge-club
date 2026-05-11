#!/usr/bin/env elixir

defmodule PWC do
  def largest(str) do
    {explain, max} = str
    |> String.codepoints |> Enum.frequencies
    |> Enum.reject(fn {_, v} -> v <= 1 end) # filter out single chars
    |> Enum.reduce({[], 0}, fn {c, _}, {explain, max} ->
      pattern = Regex.compile!("#{c}(.*)#{c}")
      substr = hd(tl(Regex.run(pattern, str)))
      {
        explain ++ [ "For character \"#{c}\", " <>
                     "we have substring \"#{substr}\"." ],
        Enum.max([max, String.length(substr)])
      }
    end)
    "#{max}\n\n" <> Enum.join(explain, "\n")
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: #{largest(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("aaaaa")

IO.puts("\nExample 2:")
PWC.solution("abcdeba")

IO.puts("\nExample 3:")
PWC.solution("abbc")

IO.puts("\nExample 4:")
PWC.solution("abcaacbc")

IO.puts("\nExample 5:")
PWC.solution("laptop")
