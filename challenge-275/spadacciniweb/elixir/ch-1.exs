# Task 1: Broken Keys
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a sentence, $sentence and list of broken keys @keys.
# Write a script to find out how many words can be typed fully.
#
# Example 1
# Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
# Output: 0
# 
# Example 2
# Input: $sentence = "Perl and Raku", @keys = ('a')
# Output: 1
# 
# Only Perl since the other word two words contain 'a' and can't be typed fully.
# 
# Example 3
# Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
# Output: 2
# 
# Example 4
# Input: $sentence = "The joys of polyglottism", @keys = ('T')
# Output: 2

defmodule BrokenKeys do

  def sentence2word(sentence, keys) do
    String.downcase(sentence)
    |> String.split(" ", trim: true)
    |> Enum.reduce(0, fn w, acc -> case count_missing(w, keys) do
                                     true  -> acc
                                     false -> acc+1
                                   end
                end)
  end

  def count_missing(word, keys) do
    keys
    |> Enum.any?(fn x -> String.contains?(word, String.downcase(x)) end)
  end

  def out(sentence, keys) do
    count_missing(sentence, keys)
    IO.puts( "sentence '#{sentence}' keys (#{Enum.join(keys, ",")}) -> #{sentence2word(sentence, keys)}" )
  end

end

sentence = "Perl Weekly Challenge";
keys = ["l", "a"];
BrokenKeys.out(sentence, keys);

sentence = "Perl and Raku"
keys = ["a"]
BrokenKeys.out(sentence, keys);

sentence = "Well done Team PWC";
keys = ["l", "o"];
BrokenKeys.out(sentence, keys);

sentence = "The joys of polyglottism";
keys = ["T"];
BrokenKeys.out(sentence, keys);
