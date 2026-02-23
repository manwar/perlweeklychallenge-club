Challenge 362
https://theweeklychallenge.org/blog/perl-weekly-challenge-362/

Task 1: Echo Chamber
Submitted by: Mohammad Sajid Anwar
You are given a string containing lowercase letters.

Write a script to transform the string based on the index position of each character (starting from 0). For each character at position i, repeat it i + 1 times.

Example 1
Input: "abca"
Output: "abbcccaaaa"

Index 0: "a" -> repeated 1 time  -> "a"
Index 1: "b" -> repeated 2 times -> "bb"
Index 2: "c" -> repeated 3 times -> "ccc"
Index 3: "a" -> repeated 4 times -> "aaaa"

Example 2
Input: "xyz"
Output: "xyyzzz"

Index 0: "x" -> "x"
Index 1: "y" -> "yy"
Index 2: "z" -> "zzz"

Example 3
Input: "code"
Output: "coodddeeee"

Index 0: "c" -> "c"
Index 1: "o" -> "oo"
Index 2: "d" -> "ddd"
Index 3: "e" -> "eeee"

Example 4
Input: "hello"
Output: "heelllllllooooo"

Index 0: "h" -> "h"
Index 1: "e" -> "ee"
Index 2: "l" -> "lll"
Index 3: "l" -> "llll"
Index 4: "o" -> "ooooo"

Example 5
Input: "a"
Output: "a"

Index 0: "a" -> "a"

Task 2: Spellbound Sorting
Submitted by: Peter Campbell Smith
You are given an array of integers.

Write a script to return them in alphabetical order, in any language of your choosing. Default language is English.

Example 1
Input: (6, 7, 8, 9 ,10)
Output: (8, 9, 7, 6, 10)

eight, nine, seven, six, ten

Example 2
Input: (-3, 0, 1000, 99)
Output: (-3, 99, 1000, 0)

minus three, ninety-nine, one thousand, zero

Example 3
Input: (1, 2, 3, 4, 5)

Output: (5, 2, 4, 3, 1) for French language
cinq, deux, quatre, trois, un

Output: (5, 4, 1, 3, 2) for English language
five, four, one, three, two

Example 4
Input: (0, -1, -2, -3, -4)
Output: (-4, -1, -3, -2, 0)

minus four, minus one, minus three, minus two, zero

Example 5
Input: (100, 101, 102)
Output: (100, 101, 102)

one hundred, one hundred and one, one hundred and two
