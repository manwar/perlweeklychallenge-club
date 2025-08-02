# Task 1: Goat Latin
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a sentence, $sentance.
# Write a script to convert the given sentence to Goat Latin, a made up language similar to Pig Latin.
# Rules for Goat Latin:
# 
# 1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
#    "ma" to the end of the word.
# 2) If a word begins with consonant i.e. not a vowel, remove first
#    letter and append it to the end then add "ma".
# 3) Add letter "a" to the end of first word in the sentence, "aa" to
#    the second word, etc etc.
# 
# Example 1
# Input: $sentence = "I love Perl"
# Output: "Imaa ovelmaaa erlPmaaaa"
# 
# Example 2
# Input: $sentence = "Perl and Raku are friends"
# Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"
# 
# Example 3
# Input: $sentence = "The Weekly Challenge"
# Output: "heTmaa eeklyWmaaa hallengeCmaaaa"

defmodule Speak do

  def head2tail(word) do
    case Regex.match?(~r/^[aeiou]i/, word) do
      true  -> word
      false -> String.slice(word, 1..String.length(word)) <> String.first(word) 
    end
  end

  def goat_latin(sentence) do
    String.split(sentence)
    |> Enum.map(fn x -> head2tail(x) <> "ma" end)
    |> Enum.with_index(1)
    |> Enum.map(fn t -> elem(t, 0) <> String.duplicate("a", elem(t, 1)) end)
    |> Enum.join(" ")
  end

  def out(sentence) do
    IO.puts( "sentence '#{sentence}' -> '#{goat_latin(sentence)}'" )
  end

end

sentence = "I love Perl";
Speak.out(sentence);

sentence = "Perl and Raku are friends";
Speak.out(sentence);

sentence = "The Weekly Challenge";
Speak.out(sentence);
