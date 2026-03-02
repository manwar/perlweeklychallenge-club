Challenge 299
https://theweeklychallenge.org/blog/perl-weekly-challenge-299/

Task 1: Replace Words
Submitted by: Mohammad Sajid Anwar
You are given an array of words and a sentence.

Write a script to replace all words in the given sentence that start with any of the words in the given array.

Example 1
Input: @words = ("cat", "bat", "rat")
       $sentence = "the cattle was rattle by the battery"
Output: "the cat was rat by the bat"
Example 2
Input: @words = ("a", "b", "c")
       $sentence = "aab aac and cac bab"
Output: "a a a c b"
Example 3
Input: @words = ("man", "bike")
       $sentence = "the manager was hit by a biker"
Output: "the man was hit by a bike"

Task 2: Word Search
Submitted by: Mohammad Sajid Anwar
You are given a grid of characters and a string.

Write a script to determine whether the given string can be found in the given grid of characters. You may start anywhere and take any orthogonal path, but may not reuse a grid cell.

Example 1
Input: @chars = (['A', 'B', 'D', 'E'],
                 ['C', 'B', 'C', 'A'],
                 ['B', 'A', 'A', 'D'],
                 ['D', 'B', 'B', 'C'])
      $str = 'BDCA'
Output: true
Example 2
Input: @chars = (['A', 'A', 'B', 'B'],
                 ['C', 'C', 'B', 'A'],
                 ['C', 'A', 'A', 'A'],
                 ['B', 'B', 'B', 'B'])
      $str = 'ABAC'
Output: false
Example 3
Input: @chars = (['B', 'A', 'B', 'A'],
                 ['C', 'C', 'C', 'C'],
                 ['A', 'B', 'A', 'B'],
                 ['B', 'B', 'A', 'A'])
      $str = 'CCCAA'
Output: true
