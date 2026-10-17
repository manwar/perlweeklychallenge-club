#!/usr/bin/env elixir

defmodule PWC do
  Mix.install([ :combinatorics ])

  def is_square(words) do
    square = Enum.into(words, [], & String.codepoints(&1) )
    get_square = fn x, y -> Enum.at(square, x) |> Enum.at(y) end
    len = hd(words) |> String.length
    for i <- 0..len-2 do
      for j <- i+1..len-1 do
        get_square.(i, j) == get_square.(j, i)
      end
    end
    |> List.flatten
    |> Enum.all?
  end

  def word_square(words) do
    len = String.length(Enum.at(words, 0))
    Combinatorics.n_combinations(len, words)
    |> Enum.reduce([], fn lst, combos ->
      combos ++ Combinatorics.permutations(lst)
    end)
    |> Enum.find(& is_square(&1))
  end

  def quote_join(array) do
    Enum.map(array, & "\"#{&1}\"" ) |> Enum.join(", ")
  end

  def solution(words) do
    IO.puts("Input: @words = (#{quote_join(words)})")
    square = word_square(words)
    IO.puts("Output: (#{quote_join(square)})\n")
    for word <- square do
      spaced = String.codepoints(word) |> Enum.join(" ")
      IO.puts("    #{spaced}")
    end
  end
end

IO.puts("Example 1:")
PWC.solution(["MA", "AM", "MY", "ME"])

IO.puts("\nExample 2:")
PWC.solution(["SUN", "USE", "NET", "SEE", "TEN"])

IO.puts("\nExample 3:")
PWC.solution(["BOAT", "TEAL", "AREA", "TSAR", "OGRE"])

IO.puts("\nExample 4:")
PWC.solution(["CARD", "AREA", "REAR", "DART"])

IO.puts("\nExample 5:")
PWC.solution(["HEART", "TREND", "EMBER", "RESIN", "ABUSE"])
