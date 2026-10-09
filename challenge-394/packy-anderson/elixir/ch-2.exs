#!/usr/bin/env elixir

defmodule PWC do
  @vowels     "[aeiou]"
  @consonants "[^aeiou]"
  @is_alternating Regex.compile!(
    "^(?:"<>@vowels<>"?(?:"<>@consonants<>@vowels<>")+|" <>
        @consonants<>"?(?:"<>@vowels<>@consonants<>")+)$"
  )

  def alt_substrings(s, i, j, substrings) do
    sub = String.slice(s, i, j-i)
    substrings =
      if Regex.match?(@is_alternating, sub),
        do: Map.put(substrings, sub, 1),
        else: substrings
    cond do
      j > i ->
        alt_substrings(s, i, j-1, substrings)
      i < String.length(s) ->
        alt_substrings(s, i+1, String.length(s), substrings)
      true ->
        substrings
    end
  end

  def alt_substrings(s) do
    alt_substrings(s, 0, String.length(s), %{})
  end

  def lcs(arr) do
    bag = alt_substrings(hd(arr))
    list = Enum.reduce(tl(arr), bag, fn s, bag ->
      Map.intersect(bag, alt_substrings(s))
    end) |> Map.keys
    if Enum.empty?(list) do
      []
    else
      sorted = Enum.sort(
        list, &( String.length(&1) >= String.length(&2))
      )
      longest = hd(sorted)
      Enum.filter(sorted, fn s ->
        String.length(s) == String.length(longest)
      end) |> Enum.sort
    end
  end

  def quote_join(array) do
    Enum.map(array, &("\"#{&1}\"")) |> Enum.join(", ")
  end

  def solution(arr) do
    IO.puts("Input: @arr = (#{quote_join(arr)})")
    IO.puts("Output: (#{quote_join(lcs(arr))})")
  end
end

IO.puts("Example 1:")
PWC.solution(["relocate", "delocate", "allocate"])

IO.puts("\nExample 2:")
PWC.solution(["apple", "banana", "cherry"])

IO.puts("\nExample 3:")
PWC.solution(["navigate", "cavity", "gravity"])

IO.puts("\nExample 4:")
PWC.solution(["pedalgia", "pedalboard", "pedantic"])

IO.puts("\nExample 5:")
PWC.solution(["schoolmaster", "schoolhouse", "schooling"])
