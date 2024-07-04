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

  @spec multiplicities(t) :: MapSet.t
  def multiplicities(multiset)
  def multiplicities(%Multiset{map: map}), do: map |> Map.values

  @spec multiplicity(t, value) :: non_neg_integer
  def multiplicity(multiset, value)
  def multiplicity(%Multiset{map: map}, value), do: Map.get(map, value, 0)
end

defmodule PWC do
  def conjunction(l) do
    if length(l) < 2 do
      l
    else
      if length(l) == 2 do
        to_string(List.first(l)) <> " and " <>
        to_string(List.last(l))
      else
        {last, rest} = List.pop_at(l, -1)
        Enum.join(rest, ", ") <> ", and " <> to_string(last)
      end
    end
  end

  def maxFrequency(ints) do
    freq = Multiset.new(ints)
    maxFreq = Enum.max(Multiset.multiplicities(freq))
    atMax = Enum.filter(Multiset.values(freq), fn i ->
      Multiset.multiplicity(freq, i) == maxFreq
    end)

    numList = conjunction(atMax)
    {elements, have} = if length(atMax) > 1 do
      {"elements", "have"}
    else
      {"element", "has"}
    end
    explain = "The maximum frequency is #{maxFreq}.\n" <>
        "The #{elements} #{numList} #{have} " <>
        "the maximum frequency."

    {maxFreq * length(atMax), explain}
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    {count, explain} = maxFrequency(ints)
    IO.puts("Output: " <> to_string(count) )
    IO.puts("\n" <> explain)
  end
end

IO.puts("Example 1:")
PWC.solution([1, 2, 2, 4, 1, 5])

IO.puts("\nExample 2:")
PWC.solution([1, 2, 3, 4, 5])
