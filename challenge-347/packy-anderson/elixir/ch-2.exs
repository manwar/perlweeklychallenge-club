#!/usr/bin/env elixir

defmodule PWC do
  def format_phone(list, formatted) when length(list) < 4 do
    formatted <> Enum.join(list)
  end

  def format_phone(list, formatted) when length(list) == 4 do
    {a, list} = {hd(list), tl(list)}
    {b, list} = {hd(list), tl(list)}
    formatted <> "#{a}#{b}-" <> Enum.join(list)
  end

  def format_phone(list, formatted) when length(list) > 4 do
    {a, list} = {hd(list), tl(list)}
    {b, list} = {hd(list), tl(list)}
    {c, list} = {hd(list), tl(list)}
    format_phone(list, formatted <> "#{a}#{b}#{c}-")
  end

  def format_phone(phone) do
    phone
    |> String.replace(~r/\D/, "")
    |> String.graphemes
    |> format_phone("")
  end

  def solution(phone) do
    IO.puts("Input: $phone = \"#{phone}\"")
    IO.puts("Output: \"#{format_phone(phone)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("1-23-45-6")

IO.puts("\nExample 2:")
PWC.solution("1234")

IO.puts("\nExample 3:")
PWC.solution("12 345-6789")

IO.puts("\nExample 4:")
PWC.solution("123 4567")

IO.puts("\nExample 5:")
PWC.solution("123 456-78")
