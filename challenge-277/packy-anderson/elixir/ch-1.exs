#!/usr/bin/env elixir

defmodule Multiset do
  @opaque t :: %Multiset{map: %{value => non_neg_integer}}
  @type value :: term
  defstruct map: %{}, size: 0

  @spec new :: t
  def new(), do: %Multiset{}

  @spec new(Enum.t) :: t
  def new(enumerable), do: Enum.reduce(enumerable, %Multiset{}, &put(&2, &1))

  @spec put(t, value, integer) :: t
  def put(multiset, value, k \\ 1)
  def put(%Multiset{map: map, size: size} = multiset, value, k) do
    if k < 1 do
      multiset
    else
      new_map = Map.update(map, value, k, fn multiplicity -> multiplicity + k end)
      new_size = size + k
      %{multiset | map: new_map, size: new_size}
    end
  end

  @spec values(t) :: MapSet.t
  def values(multiset)
  def values(%Multiset{map: map}), do: map |> Map.keys |> MapSet.new

  @spec multiplicity(t, value) :: non_neg_integer
  def multiplicity(multiset, value)
  def multiplicity(%Multiset{map: map}, value), do: Map.get(map, value, 0)
end

defmodule PWC do
  def countCommon(words1, words2) do
    # make Multisets that count the words
    counts1 = words1
      |> Enum.map(fn w -> String.downcase(w) end)
      |> Multiset.new
    counts2 = words2
      |> Enum.map(fn w -> String.downcase(w) end)
      |> Multiset.new

    # filter to get set of words occuring only once
    counts1 = counts1
      |> Multiset.values
      |> Enum.filter(fn w -> Multiset.multiplicity(counts1, w) == 1 end)
      |> MapSet.new
    counts2 = counts2
      |> Multiset.values
      |> Enum.filter(fn w -> Multiset.multiplicity(counts2, w) == 1 end)
      |> MapSet.new

    # find the elements common in both
    common = MapSet.intersection(counts1, counts2)
    MapSet.size(common)
  end

  def solution(words1, words2) do
    IO.puts("Input: @words1 = (\"" <> Enum.join(words1, "\", \"") <> "\")")
    IO.puts("       @words2 = (\"" <> Enum.join(words2, "\", \"") <> "\")")
    IO.puts("Output: " <> to_string(countCommon(words1, words2)) )
  end
end

IO.puts("Example 1:")
PWC.solution(
  ["Perl", "is", "my", "friend"],
  ["Perl", "and", "Raku", "are", "friend"]
)

IO.puts("\nExample 2:")
PWC.solution(
  ["Perl", "and", "Python", "are", "very", "similar"],
  ["Python", "is", "top", "in", "guest", "languages"]
)

IO.puts("\nExample 3:")
PWC.solution(
  ["Perl", "is", "imperative", "Lisp", "is", "functional"],
  ["Crystal", "is", "similar", "to", "Ruby"]
)
