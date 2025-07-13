#!/usr/bin/env elixir

defmodule PWC do
  def swap_case(l) do
    if String.downcase(l) == l,
      do: String.upcase(l),
      else: String.downcase(l)
  end

  defp find_longest(string, longest) do
    longest = if String.length(string) > String.length(longest),
      do: string, else: longest
    {string, longest}
  end

  def nice_string(str) do
    # convert the string to a Bag, er, MapSet
    # so we know which characters are in it
    seen = MapSet.new(String.codepoints(str))

    # filter the letters and make a list
    # of those that only appear in one case
    not_both_cases
      =  String.codepoints(str)
      |> Enum.filter(fn l ->
           not MapSet.member?(seen, swap_case(l))
         end)

    # build a regex of the characters we're removing
    {_, replace} = cond do
      # no characters to replace, use a regex of chars
      # we'll never see, like a SPACE
      Enum.empty?(not_both_cases) -> Regex.compile(" ")
      true -> ["["] ++ not_both_cases ++ ["]+"]
        |> Enum.join
        |> Regex.compile
    end

    # replace lower case letters with space, then
    # get rid of leading and trailing space, then
    # split on whitespace, then
    # build return array of distinct values
    {_, output}
      =  Regex.replace(replace, str, " ")
      |> String.trim
      |> String.split
      |> Enum.map_reduce("", &find_longest/2)

    output
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{nice_string(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("YaaAho")

IO.puts("\nExample 2:")
PWC.solution("cC")

IO.puts("\nExample 3:")
PWC.solution("A")

IO.puts("\nExample 4:")
PWC.solution("AaBcDEFdefGhIiJjKlm")
