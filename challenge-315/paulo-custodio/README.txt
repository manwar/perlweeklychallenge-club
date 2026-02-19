Challenge 315
https://theweeklychallenge.org/blog/perl-weekly-challenge-315/

Task 1: Find Words
Submitted by: Mohammad Sajid Anwar
You are given a list of words and a character.

Write a script to return the index of word in the list where you find the given character.


Example 1
Input: @list = ("the", "weekly", "challenge")
       $char = "e"
Output: (0, 1, 2)

Example 2
Input: @list = ("perl", "raku", "python")
       $char = "p"
Output: (0, 2)

Example 3
Input: @list = ("abc", "def", "bbb", "bcd")
       $char = "b"
Output: (0, 2, 3)

Task 2: Find Third
Submitted by: Mohammad Sajid Anwar
You are given a sentence and two words.

Write a script to return all words in the given sentence that appear in sequence to the given two words.


Example 1
Input: $sentence = "Perl is a my favourite language but Python is my favourite too."
       $first = "my"
       $second = "favourite"
Output: ("language", "too")

Example 2
Input: $sentence = "Barbie is a beautiful doll also also a beautiful princess."
       $first = "a"
       $second = "beautiful"
Output: ("doll", "princess")

Example 3
Input: $sentence = "we will we will rock you rock you.",
       $first = "we"
       $second = "will"
Output: ("we", "rock")
