#!/usr/bin/env elixir

defmodule PWC do
  # build up the lines like "h = 104"
  def explain_mapping([], [], explain), do: explain
  def explain_mapping([c | chars], [v | vals], explain) do
    explain_mapping(chars, vals, explain ++ ["#{c} = #{v}"])
  end

  # process the list of codepoints and explain our calculations
  def process_list([], _, line1, line2), do: {line1, line2}
  def process_list([next | vals], last, line1, line2) do
    line1 = line1 ++ ["| #{last} - #{next} |"]
    line2 = line2 ++ [ abs(last - next) ]
    process_list(vals, next, line1, line2)
  end

  def score(str) do
    chars = String.graphemes(str)
    vals  = String.to_charlist(str)

    # generate the first part of the explanation
    explain = explain_mapping(
      chars, vals, ["ASCII values of characters:"]
    )

    # get the first codepoint off the list
    {last, vals} = List.pop_at(vals, 0)
    # process the rest of the codepoints
    {line1, line2} = process_list(vals, last, [], [])

    # now format the last part of the explanation
    line1str = Enum.join(line1, " + ")
    explain  = explain ++ ["Score => #{line1str}"]
    line2str = Enum.join(line2, " + ")
    explain  = explain ++ ["      => #{line2str}"]
    scoreVal = Enum.sum(line2)
    explain  = explain ++ ["      => #{scoreVal}"]

    { scoreVal, Enum.join(explain, "\n") }
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    {scoreVal, explain} = score(str)
    IO.puts("Output: #{scoreVal}\n\n#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution("hello")

IO.puts("\nExample 2:")
PWC.solution("perl")

IO.puts("\nExample 3:")
PWC.solution("raku")
