#!/usr/bin/env elixir

defmodule PWC do
  defp closest(num) do
    [0, 51, 102, 153, 204, 255]  # safe colors
    |> Enum.map(&( num - &1 ))   # find difference
    |> Enum.min_by(&( abs(&1) )) # min abs difference
    |> then(&( num - &1 ))       # subtract min value
  end

  def nearest_rgb(color) do
    # grab color codes from color spec
    Regex.scan(~r/#(..)(..)(..)/, color, capture: :all_but_first)
    |> hd # it's a list of lists, we only need the first list
    |> Enum.map(&(
      String.to_integer(&1, 16)     # parse as hex
      |> closest                    # find closest web-safe value
      |> Integer.to_string(16)      # convert back to hex
      |> String.pad_leading(2, "0") # pad with 0
    ))
    |> Enum.join
    |> then(&( "#" <> &1 ))
  end

  def solution(color) do
    IO.puts("Input: $color = \"#{color}\"")
    IO.puts("Output: \"#{nearest_rgb(color)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("#F4B2D1")

IO.puts("\nExample 2:")
PWC.solution("#15E6E5")

IO.puts("\nExample 3:")
PWC.solution("#191A65")

IO.puts("\nExample 4:")
PWC.solution("#2D5A1B")

IO.puts("\nExample 5:")
PWC.solution("#00FF66")
