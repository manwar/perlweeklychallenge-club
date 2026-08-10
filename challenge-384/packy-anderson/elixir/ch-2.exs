#!/usr/bin/env elixir

defmodule PWC do
  def rematch?(re, substr), do:
    Regex.match?(~r/^1+$/, Regex.replace(re, substr, ""))

  def special_binary_substrings(binary) do
    arr = String.codepoints(binary)
    |> Enum.map(&( String.to_integer(&1) ))
    len = length(arr)
    sum = Enum.sum(arr)
    cond do
      # special case: all 0s or all 1s
      sum == 0 or sum == len -> []
      true ->
        Enum.reduce(0 .. len-1, %{}, fn i, seen ->
          Enum.reduce(i+1 .. len, seen, fn j, seen ->
            subarr = Enum.slice(arr, i..j)
            substr = Enum.map(subarr, &( Integer.to_string(&1) ))
            |> Enum.join
            if Map.has_key?(seen, substr) do
              seen
            else
              if Enum.sum(subarr) == length(subarr)/2 do
                # equal num 0 & 1
                cond do
                  rematch?(~r/^0+/, substr) or
                  rematch?(~r/0+$/, substr) ->
                    Map.put(seen, substr, true) # consecutive
                  true -> Map.put(seen, substr, false)
                end
              else
                Map.put(seen, substr, false)
              end
            end
          end)
        end)
        |> Map.filter(fn {_k, v} -> v end)
        |> Map.keys
        |> Enum.sort
    end
  end

  def quote_join(array) do
    Enum.map(array, &("\"#{&1}\"")) |> Enum.join(", ")
  end

  def solution(binary) do
    IO.puts("Input: $binary = \"#{binary}\"")
    output = quote_join(special_binary_substrings(binary))
    IO.puts("Output: (#{output})")
  end
end

IO.puts("Example 1:")
PWC.solution("0101")

IO.puts("\nExample 2:")
PWC.solution("000111")

IO.puts("\nExample 3:")
PWC.solution("000011")

IO.puts("\nExample 4:")
PWC.solution("10011100")

IO.puts("\nExample 5:")
PWC.solution("00000")
