#!/usr/bin/env elixir

defmodule PWC do
  defp table(), do: Map.new(~c[abcdefghij], fn c ->
    { to_string([c]), to_string([c - 49]) }
  end)

  defp translate(str) do
    str
    |> String.codepoints
    |> Enum.reduce([], fn c, list ->
      list ++ [ Map.get(table(), c) ]
    end)
    |> Enum.join
  end

  defp pquote(str, width) do
    String.pad_leading("\"#{str}\"", width)
  end

  def sum_of_words(str1, str2, str3) do
    width = Enum.max([
      String.length(str1),
      String.length(str2),
      String.length(str3)
    ])
    num1 = translate(str1)
    num2 = translate(str2)
    num3 = translate(str3)
    result = if String.to_integer(num1) +
                String.to_integer(num2) ==
                String.to_integer(num3), do: "True",
                                       else: "False"
    {
      result,
      "$str1 = #{pquote(str1, width+2)} = " <>
      "#{num1 |> String.pad_leading(width)}\n" <>
      "$str2 = #{pquote(str2, width+2)} = " <>
      "#{num2 |> String.pad_leading(width)}\n" <>
      "$str3 = #{pquote(str3, width+2)} = " <>
      "#{num3 |> String.pad_leading(width)}"
    }
  end

  def solution(str1, str2, str3) do
    IO.puts("Input: $str1 = \"#{str1}\", $str2 = \"#{str2}\", " <>
            "$str3 = \"#{str3}\"")
    {result, explain} = sum_of_words(str1, str2, str3)
    IO.puts("Output: #{result}\n\n#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution("acb", "cba", "cdb")

IO.puts("\nExample 2:")
PWC.solution("aab", "aac", "ad")

IO.puts("\nExample 3:")
PWC.solution("bc", "je", "jg")

IO.puts("\nExample 4:")
PWC.solution("a", "aaaa", "aa")

IO.puts("\nExample 5:")
PWC.solution("c", "d", "h")

IO.puts("\nExample 6:")
PWC.solution("gfi", "hbf", "bdhd")
