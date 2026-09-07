#!/usr/bin/env elixir

Mix.install([ :excribe ])

defmodule PWC do
  def dyck_words(n) when n == 0, do: [""]
  def dyck_words(n) when n == 1, do: ["UD"]
  def dyck_words(n) do
    Enum.reduce(1..Integer.floor_div(n,2), [], fn i, new ->
      Enum.reduce(dyck_words(n - i), new, fn word1, new ->
        Enum.reduce(dyck_words(i), new, fn word2, new ->
          pre  = String.slice(word2, 0, i)
          post = String.slice(word2, i, i*2)
          new ++ [
            word2 <> word1,
            word1 <> word2,
            pre <> word1 <> post
          ]
        end)
      end)
    end)
    |> Enum.sort |> Enum.uniq
  end

  def quote_join(array) do
    Enum.map(array, &("\"#{&1}\"")) |> Enum.join(", ")
  end

  def solution(n) do
    IO.puts("Input: $n = #{n}")
    words = quote_join(dyck_words(n))
    words = Excribe.format(words, %{width: 70, hanging: 9})
    IO.puts("Output: (#{words})")
  end
end

IO.puts("Example 1:")
PWC.solution(1)

IO.puts("\nExample 2:")
PWC.solution(2)

IO.puts("\nExample 3:")
PWC.solution(3)

IO.puts("\nExample 4:")
PWC.solution(0)

IO.puts("\nExample 5:")
PWC.solution(4)
