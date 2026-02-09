Challenge 359
https://theweeklychallenge.org/blog/perl-weekly-challenge-359/

Task 1: Digital Root
Submitted by: Mohammad Sajid Anwar
You are given a positive integer, $int.

Write a function that calculates the additive persistence of a positive integer and also return the digital root.

Digital root is the recursive sum of all digits in a number until a single digit is obtained.

Additive persistence is the number of times you need to sum the digits to reach a single digit.

Example 1
Input: $int = 38
Output: Persistence  = 2
        Digital Root = 2

38 => 3 + 8 => 11
11 => 1 + 1 => 2

Example 2
Input: $int = 7
Output: Persistence  = 0
        Digital Root = 7

Example 3
Input: $int = 999
Output: Persistence  = 2
        Digital Root = 9

999 => 9 + 9 + 9 => 27
27  => 2 + 7 => 9

Example 4
Input: $int = 1999999999
Output: Persistence  = 3
        Digital Root = 1

1999999999 => 1 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 => 82
82 => 8 + 2 => 10
10 => 1 + 0 => 1

Example 5
Input: $int = 101010
Output: Persistence  = 1
        Digital Root = 3

101010 => 1 + 0 + 1 + 0 + 1 + 0 => 3

Task 2: String Reduction
Submitted by: Mohammad Sajid Anwar
You are given a word containing only alphabets,

Write a function that repeatedly removes adjacent duplicate characters from a string until no adjacent duplicates remain and return the final word.

Example 1
Input: $word = "aabbccdd"
Output: ""

Iteration 1: remove "aa", "bb", "cc", "dd" => ""

Example 2
Input: $word = "abccba"
Output: ""

Iteration 1: remove "cc" => "abba"
Iteration 2: remove "bb" => "aa"
Iteration 3: remove "aa" => ""

Example 3
Input: $word = "abcdef"
Output: "abcdef"

No duplicate found.

Example 4
Input: $word = "aabbaeaccdd"
Output: "aea"

Iteration 1: remove "aa", "bb", "cc", "dd" => "aea"

Example 5
Input: $word = "mississippi"
Output: "m"

Iteration 1: Remove "ss", "ss", "pp" => "miiii"
Iteration 2: Remove "ii", "ii" => "m"
