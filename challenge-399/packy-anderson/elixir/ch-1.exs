#!/usr/bin/env elixir

defmodule PWC do
  import Enum

  @doc """
  Extract all the substrings made up of the same character
  """
  def substrings(str) do
    ~r/((.)\g-1*)/
    |> Regex.scan(str)
    |> map(&List.first!(&1))
  end

  @doc """
  replace the first character of the ($i+1)th string
  with the first character of the ($i)th string
  """
  def shift_right(i, strings), do: shift_char(i, :r, strings)

  @doc """
  replace the last character of the ($i)th string
  with the first character of the ($i+1)th string
  """
  def shift_left(i, strings), do: shift_char(i, :l, strings)

  defp shift_char(i, dir, strings) do
    s = if dir == :r, do: i, else: i - 1

    Range.new(0, s, 1)
    |> reduce("", fn j, newstr -> newstr <> at(strings, j) end)
    |> then(
      &(&1 <>
          case dir do
            :r -> String.slice(at(strings, i), 0..0)
            :l -> String.slice(at(strings, i), 1..-1//1)
          end)
    )
    |> then(
      &(&1 <>
          case dir do
            :r -> String.slice(at(strings, i + 1), 1..-1//1)
            :l -> String.slice(at(strings, i + 1), 0..0)
          end)
    )
    |> then(
      &(Range.new(i + 2, length(strings) - 1, 1)
        |> reduce(&1, fn j, newstr ->
          newstr <> at(strings, j)
        end))
    )
  end

  def longest_repeating_character(str, k) do
    # gather the substrings
    subs = substrings(str)

    if k == 0 or length(subs) == 1 do
      # no more substitutions or only one substring
      subs
      |> map(&String.length(&1))
      |> max()
    else
      # shorten long name
      lrc = &longest_repeating_character/2

      # make new substrings recursively
      Range.new(0, length(subs) - 2, 1)
      |> reduce(%{}, fn i, longest ->
        newstr = shift_right(i, subs)

        longest = Map.put(longest, newstr, lrc.(newstr, k - 1))

        newstr = shift_left(i, subs)

        Map.put(longest, newstr, lrc.(newstr, k - 1))
      end)
      |> Map.values()
      |> max()
    end
  end

  def solution(str, k) do
    IO.puts("Input: $str = \"#{str}\", $k = #{k}")
    len = longest_repeating_character(str, k)
    IO.puts("Output: #{len}")
  end
end

IO.puts("Example 1")
PWC.solution("AAAAA", 2)

IO.puts("\nExample 2")
PWC.solution("ABCDE", 4)

IO.puts("\nExample 3")
PWC.solution("AAABBBBAA", 1)

IO.puts("\nExample 4")
PWC.solution("ABACADA", 2)

IO.puts("\nExample 5")
PWC.solution("BAAABAAAA", 1)
