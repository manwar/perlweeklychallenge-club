Challenge 307
https://theweeklychallenge.org/blog/perl-weekly-challenge-307/

Task 1: Check Order
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to re-arrange the given array in an increasing order and return the indices where it differs from the original array.

Example 1
Input: @ints = (5, 2, 4, 3, 1)
Output: (0, 2, 3, 4)

Before: (5, 2, 4, 3, 1)
After : (1, 2, 3, 4, 5)

Difference at indices: (0, 2, 3, 4)
Example 2
Input: @ints = (1, 2, 1, 1, 3)
Output: (1, 3)

Before: (1, 2, 1, 1, 3)
After : (1, 1, 1, 2, 3)

Difference at indices: (1, 3)
Example 3
Input: @ints = (3, 1, 3, 2, 3)
Output: (0, 1, 3)

Before: (3, 1, 3, 2, 3)
After : (1, 2, 3, 3, 3)

Difference at indices: (0, 1, 3)

Task 2: Find Anagrams
Submitted by: Mohammad Sajid Anwar
You are given a list of words, @words.

Write a script to find any two consecutive words and if they are anagrams, drop the first word and keep the second. You continue this until there is no more anagrams in the given list and return the count of final list.

Example 1
Input: @words = ("acca", "dog", "god", "perl", "repl")
Output: 3

Step 1: "dog" and "god" are anagrams, so dropping "dog" and keeping "god" => ("acca", "god", "perl", "repl")
Step 2: "perl" and "repl" are anagrams, so dropping "perl" and keeping "repl" => ("acca", "god", "repl")
Example 2
Input: @words = ("abba", "baba", "aabb", "ab", "ab")
Output: 2

Step 1: "abba" and "baba" are anagrams, so dropping "abba" and keeping "baba" => ("baba", "aabb", "ab", "ab")
Step 2: "baba" and "aabb" are anagrams, so dropping "baba" and keeping "aabb" => ("aabb", "ab", "ab")
Step 3: "ab" and "ab" are anagrams, so dropping "ab" and keeping "ab" => ("aabb", "ab")
