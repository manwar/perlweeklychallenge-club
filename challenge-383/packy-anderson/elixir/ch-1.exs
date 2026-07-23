#!/usr/bin/env elixir

defmodule PWC do
  def in_sublist(_, []), do: []

  def in_sublist(word, [sublist | rest]) do
    if Enum.any?(sublist, fn w -> w == word end) do
      sublist
    else
      in_sublist(word, rest)
    end
  end

  # are the lists the same length?
  def similar(list1, list2, _)
    when length(list1) != length(list2), do: "False"

  def similar(list1, list2, list3) do
    # eliminate identical words
    {list1, list2} = Enum.reduce(
      list1, {list1, list2}, fn word, {list1, list2} ->
        if Enum.any?(list2, fn w -> w == word end) do
          { List.delete(list1, word), List.delete(list2, word) }
        else
          {list1, list2}
        end
      end)

    # eliminate "similar" words using list3
    {list1, list2} = Enum.reduce(
      list1, {list1, list2}, fn word, {list1, list2} ->
        sublist = in_sublist(word, list3)
        if length(sublist) > 0 do
          Enum.reduce_while(
            list2, {list1, list2}, fn word2, {list1, list2} ->
              if Enum.any?(sublist, fn w -> w == word2 end) do
                {:halt, {
                  List.delete(list1, word),
                  List.delete(list2, word2)
                }}
              else
                {:cont, {list1, list2}}
              end
            end)
        else
          {list1, list2}
        end
      end)

    if length(list1) == length(list2) and length(list2) == 0,
     do: "True", else: "False"
  end

  def quote_join(array) do
    Enum.map(array, &("\"#{&1}\"")) |> Enum.join(", ")
  end

  def solution(list1, list2, list3) do
    IO.puts("Input: $list1 = (#{quote_join(list1)})")
    IO.puts("       $list2 = (#{quote_join(list2)})")
    l3 = Enum.map(list3, &("[" <> quote_join(&1) <> "]"))
    IO.puts("       $list3 = (" <> Enum.join(l3, ", ") <> ")")
    IO.puts("Output: #{similar(list1, list2, list3)}")
  end
end

IO.puts("Example 1:")
PWC.solution(["great", "acting"], ["fine", "drama"],
            [["great", "fine"], ["acting", "drama"]])

IO.puts("\nExample 2:")
PWC.solution(["apple", "pie"], ["banana", "pie"],
            [["apple", "peach"], ["peach", "banana"]])

IO.puts("\nExample 3:")
PWC.solution(["perl4", "python"], ["raku", "python"],
             [["perl4", "perl5", "raku"], ])

IO.puts("\nExample 4:")
PWC.solution(["enjoy", "challenge"], ["love", "weekly", "challenge"],
             [["enjoy", "love"], ])

IO.puts("\nExample 5:")
PWC.solution(["fast", "car"], ["quick", "vehicle"],
             [["quick", "fast"], ["vehicle", "car"]])
