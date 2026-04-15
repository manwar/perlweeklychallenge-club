#!/usr/bin/env elixir

defmodule PWC do
  def valid_tag(caption) do
    String.slice("#" <> (
      Regex.replace(~r/[^a-zA-Z\s]/, caption, "")
      |> String.split(" ", trim: true)
      |> Enum.zip(0..String.length(caption))
      |> Enum.map_join(fn {val, key} ->
           if key==0, do: String.downcase(val),
                    else: String.capitalize(val)
         end)
    ), 0..99)
  end

  def solution(caption) do
    IO.puts("Input: $caption = \"#{caption}\"")
    IO.puts("Output: \"#{valid_tag(caption)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("Cooking with 5 ingredients!")

IO.puts("\nExample 2:")
PWC.solution("the-last-of-the-mohicans")

IO.puts("\nExample 3:")
PWC.solution("  extra spaces here")

IO.puts("\nExample 4:")
PWC.solution("iPhone 15 Pro Max Review")

IO.puts("\nExample 5:")
PWC.solution("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!")
