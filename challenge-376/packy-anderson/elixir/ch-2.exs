#!/usr/bin/env elixir

defmodule PWC do
  import String

  def double_double(str) do
    str # find doubled words and wrap them
    |> replace(~r/\b(\w+)\b((?:<[^>]+>|\s|\n)+)\b(\1)\b/i,
               "[\\1]\\2[\\3]")
    # strip away lines that were not changed
    |> replace(~r/^[^\[]+\n/, "") # lines starting
    |> replace(~r/\n[^\[]+$/, "") # lines ending
    |> replace(~r/^[^\[]+$/,  "") # no subs
  end

  def display_newlines(str) do
    str |> replace(~r/\n/, "\\n")
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{display_newlines(str)}\"")
    IO.puts("Output: \"#{display_newlines(double_double(str))}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing.")

IO.puts("\nExample 2:")
PWC.solution("Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words.")

IO.puts("\nExample 3:")
PWC.solution("to make a word bold: '...it is <B>very</B> very important...'.")

IO.puts("\nExample 4:")
PWC.solution("Perl officially stands for Practical Extraction and Report Language, except when it doesn't.")

IO.puts("\nExample 5:")
PWC.solution("There's more than one one way to do it.\nEasy things should be easy and hard things should be possible.")
