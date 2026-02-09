Challenge 360
https://theweeklychallenge.org/blog/perl-weekly-challenge-360/

Task 1: Text Justifier
Submitted by: Mohammad Sajid Anwar
You are given a string and a width.

Write a script to return the string that centers the text within that width using asterisks * as padding.

Example 1
Input: $str = "Hi", $width = 5
Output: "*Hi**"

Text length = 2, Width = 5
Need 3 padding characters total
Left padding: 1 star, Right padding: 2 stars

Example 2
Input: $str = "Code", $width = 10
Output: "***Code***"

Text length = 4, Width = 10
Need 6 padding characters total
Left padding: 3 stars, Right padding: 3 stars

Example 3
Input: $str = "Hello", $width = 9
Output: "**Hello**"

Text length = 5, Width = 9
Need 4 padding characters total
Left padding: 2 stars, Right padding: 2 stars

Example 4
Input: $str = "Perl", $width = 4
Output: "Perl"

No padding needed

Example 5
Input: $str = "A", $width = 7
Output: "***A***"

Text length = 1, Width = 7
Need 6 padding characters total
Left padding: 3 stars, Right padding: 3 stars

Example 6
Input: $str = "", $width = 5
Output: "*****"

Text length = 0, Width = 5
Entire output is padding

Task 2: Word Sorter
Submitted by: Mohammad Sajid Anwar
You are give a sentence.

Write a script to order words in the given sentence alphabetically but keeps the words themselves unchanged.

Example 1
Input: $str = "The quick brown fox"
Output: "brown fox quick The"

Example 2
Input: $str = "Hello    World!   How   are you?"
Output: "are Hello How World! you?"

Example 3
Input: $str = "Hello"
Output: "Hello"

Example 4
Input: $str = "Hello, World! How are you?"
Output: "are Hello, How World! you?"

Example 5
Input: $str = "I have 2 apples and 3 bananas!"
Output: "2 3 and apples bananas! have I"
