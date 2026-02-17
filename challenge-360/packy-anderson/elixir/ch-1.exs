#!/usr/bin/env elixir

defmodule PWC do
  # handle special cases
  def justify(str, len, width) when len >= width, do:
    {str, "No padding needed"}

  def justify(_, len, width) when len == 0, do:
    {
      String.duplicate("*", width),
      "Text length = 0, Width = #{width}\n" <>
      "Entire output is padding"
    }

  def justify(str, len, width) do
    pad   = width - len
    lside = div(pad, 2)
    rside = pad - lside
    {
      String.duplicate("*", lside) <> str <>
      String.duplicate("*", rside),

      "Text length = #{len}, Width = #{width}\n" <>
      "Need #{pad} padding characters total\n" <>
      "Left padding: #{lside} stars, " <>
      "Right padding: #{rside} stars"
    }
  end

  def justify(str, width) do
    justify(str, String.length(str), width)
  end

  def solution(str, width) do
    IO.puts("Input: $str = \"#{str}\", $width = #{width}")
    {output, explain} = justify(str, width)
    IO.puts("Output: \"#{output}\"\n\n#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution("Hi", 5)

IO.puts("\nExample 2:")
PWC.solution("Code", 10)

IO.puts("\nExample 3:")
PWC.solution("Hello", 9)

IO.puts("\nExample 4:")
PWC.solution("Perl", 4)

IO.puts("\nExample 5:")
PWC.solution("A", 7)

IO.puts("\nExample 6:")
PWC.solution("", 5)
