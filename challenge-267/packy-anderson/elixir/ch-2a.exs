#!/usr/bin/env elixir

# You are given a string, $str, and a 26-items array @widths
# containing the width of each character from a to z.

# Write a script to find out the number of lines and the width
# of the last line needed to display the given string,
# assuming you can only fit 100 width units on a line.

# Example 1
# Input: $str = "abcdefghijklmnopqrstuvwxyz"
#        @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,
#                   10,10,10,10,10,10,10,10,10,10,10,10,10)
# Output: (3, 60)
#
# Line 1: abcdefghij (100 pixels)
# Line 2: klmnopqrst (100 pixels)
# Line 3: uvwxyz (60 pixels)

# Example 2
# Input: $str = "bbbcccdddaaa"
#        @widths = (4,10,10,10,10,10,10,10,10,10,10,10,10,
#                   10,10,10,10,10,10,10,10,10,10,10,10,10)
# Output: (2, 4)
#
# Line 1: bbbcccdddaa (98 pixels)
# Line 2: a (4 pixels)

defmodule PWC do
  @alphabet String.split("abcdefghijklmnopqrstuvwxyz", "", trim: true)

  defp updateExplain(vars) do
    # because this is being called with an older version of vars
    # (before lines is incremented), we need to add one to the value
    # in this function
    vars[:explain] <> "\nLine " <> to_string(vars[:lines] + 1) <>
    ": #{vars[:last_line]} (#{to_string(vars[:line_width])} pixels)"
  end

  # if the character list is empty
  defp charCount([], _widthMap, vars) do
    %{vars |
      explain: updateExplain(vars),
      lines: vars[:lines] + 1
    }
  end

  # split the character list into the first character
  # and all the remaining characters in the list
  defp charCount([c | remaining], widthMap, vars) do
    char_width = widthMap[c]
    vars = if vars[:line_width] + char_width > 100 do
      %{vars |
        explain: updateExplain(vars),
        lines: vars[:lines] + 1,
        line_width: char_width,
        last_line: c
      }
    else
      %{vars |
        line_width: vars[:line_width] + char_width,
        last_line: vars[:last_line] <> c
      }
    end
    charCount(remaining, widthMap, vars)
  end

  def lineCounts(str, widths) do
    widthMap = Enum.zip(@alphabet, widths)
             |> Map.new()
    vars = %{
      lines: 0,
      line_width: 0,
      last_line: "",
      explain: ""
    }
    charCount(String.split(str, "", trim: true), widthMap, vars)
  end

  def solution(str, widths) do
    IO.puts("Input: $str = '#{str}'")
    IO.puts("       @widths = (#{Enum.join(widths, ", ")})")
    vars = PWC.lineCounts(str, widths)
    IO.puts("Output: (#{to_string(vars[:lines])}, " <>
            "#{to_string(vars[:line_width])})#{vars[:explain]}")
  end
end

IO.puts("Example 1:")
PWC.solution(
  "abcdefghijklmnopqrstuvwxyz",
  [10,10,10,10,10,10,10,10,10,10,10,10,10,
   10,10,10,10,10,10,10,10,10,10,10,10,10]
)

IO.puts("\nExample 2:")
PWC.solution(
  "bbbcccdddaaa",
  [ 4,10,10,10,10,10,10,10,10,10,10,10,10,
   10,10,10,10,10,10,10,10,10,10,10,10,10]
)

IO.puts("\nExample 3:")
PWC.solution(
  "thequickbrownfoxjumpedoverthelazydog",
  [7,8,7,8,7,5,8,8,4,4,8,4,12,
   8,8,8,8,5,6,4,8,8,12,8,8,7]
)
