#!/usr/bin/env elixir

Mix.install([ :excribe ])
defmodule PWC do
  def reassemble([], _, word), do: word

  def reassemble([c | remaining], letters, word) do
    cond do
      Regex.match?(~r/\p{L}/u, c) ->
        # if it's a letter, pull it's replacement
        # off the letters array
        {next, letters} = List.pop_at(letters, 0)
        reassemble(remaining, letters, word <> next)
      true ->
        # otherwise, it's punctuation, so
        # leave it alone
        reassemble(remaining, letters, word <> c)
    end
  end

  def rearrange(word) when length(word) < 3, do: word

  def rearrange(word) do
    chars = String.codepoints(word) # break word into characters
    letters = Enum.filter(
      chars,
      fn c -> Regex.match?(~r/\p{L}/u, c) end # only letters
    )
    {first, letters} = List.pop_at(letters, 0) # remove the first letter
    {last, letters}  = List.pop_at(letters,-1) # remove the last letter
    letters = Enum.shuffle(letters) # shuffle the remaining letters
    |> List.insert_at(0, first)     # put the first letter back
    |> List.insert_at(-1, last)     # put the last letter back

    # reassemble the word
    reassemble(chars, letters, "")
  end

  def jumbleLetters(text) do
    String.split(text)
    |> Enum.map(fn word -> rearrange(word) end)
    |> Enum.join(" ")
  end

  def solution(text) do
    IO.puts("Input:")
    IO.puts(Excribe.format(text, %{width: 65}))
    jumbled = jumbleLetters(text)
    IO.puts("\nOutput:")
    IO.puts(Excribe.format(jumbled, %{width: 65}))
  end
end

IO.puts("Example 1:")
PWC.solution(
  "According to research at Cambridge University, it doesn't " <>
  "matter in what order the letters in a word are, the only " <>
  "important thing is that the first and last letter be at " <>
  "the right place. The rest can be a total mess and you can " <>
  "still read it without problem.  This is because the human " <>
  "mind does not read every letter by itself, but the word as " <>
  "a whole."
)

IO.puts("\nExample 2:")
PWC.solution("Perl Weekly Challenge")

IO.puts("\nExample 3:")
PWC.solution(
  "’Twas brillig, and the slithy toves " <>
  "Did gyre and gimble in the wabe: " <>
  "All mimsy were the borogoves, " <>
  "And the mome raths outgrabe."
)

IO.puts("\nExample 4:")
PWC.solution(
  "My mother-in-law says I shouldn't've have used " <>
  "so many parentheticals (but I completely disagree!)."
)
