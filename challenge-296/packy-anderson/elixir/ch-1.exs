#!/usr/bin/env elixir

defmodule PWC do
  def encodeLastCount(last, count, result) do
    if count > 1 do
      result <> to_string(count) <> last
    else
      result <> last
    end
  end

  def rlEncode([], last, count, result), do:
    encodeLastCount(last, count, result)

  def rlEncode([c | rest], last, count, result) do
    if c == last do
      # increment the count of times we saw this character
      rlEncode(rest, last, count + 1, result)
    else
      # make c the new last and 1 the new count
      rlEncode(rest, c, 1, encodeLastCount(last, count, result))
    end
  end

  def rlEncode(chars) do
    chars = String.graphemes(chars) # break string into chars
    [last | rest] = chars # grab the first character
    rlEncode(rest, last, 1, "") # start with that as last char
  end

  def addCharToResult(count, char, result) do
    count = if String.length(count) > 0 do
      # if there's a count, convert to int
      String.to_integer(count)
    else
      1 # empty count string means one char
    end
    result <> String.duplicate(char, count) # repeat the char
  end

  def rlDecode([], _, result), do: result

  def rlDecode([next | rest], count, result) do
    if Regex.match?(~r/\d/, next) do
      # it's a numeric char, add it to the count
      # and process the next character
      rlDecode(rest, count <> next, result)
    else
      # it's an alpha char, add it to the result
      rlDecode(rest, "", addCharToResult(count, next, result))
    end
  end

  def rlDecode(chars) do
    chars = String.graphemes(chars) # break string into chars
    rlDecode(chars, "", "")
  end

  def solution(chars) do
    IO.puts("Input: $chars = \"#{chars}\"")
    encoded = rlEncode(chars)
    IO.puts("Encoded: \"#{encoded}\"")
    decoded = rlDecode(encoded)
    IO.puts("Decoded: \"#{decoded}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("abbc")

IO.puts("\nExample 2:")
PWC.solution("aaabccc")

IO.puts("\nExample 3:")
PWC.solution("abcc")

IO.puts("\nExample 4:")
PWC.solution("abbbbbbbbbbbbccccccdd")
