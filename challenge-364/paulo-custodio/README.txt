Perl Weekly Challenge 364
https://theweeklychallenge.org/blog/perl-weekly-challenge-364/

Task 1: Decrypt String
Submitted by: Mohammad Sajid Anwar
You are given a string formed by digits and ‘#'.

Write a script to map the given string to English lowercase characters following the given rules.

- Characters 'a' to 'i' are represented by '1' to '9' respectively.
- Characters 'j' to 'z' are represented by '10#' to '26#' respectively.

Example 1
Input: $str = "10#11#12"
Output: "jkab"

10# -> j
11# -> k
1   -> a
2   -> b

Example 2
Input: $str = "1326#"
Output: "acz"

1   -> a
3   -> c
26# -> z

Example 3
Input: $str = "25#24#123"
Output: "yxabc"

25# -> y
24# -> x
1   -> a
2   -> b
3   -> c

Example 4
Input: $str = "20#5"
Output: "te"

20# -> t
5   -> e

Example 5
Input: $str = "1910#26#"
Output: "aijz"

1   -> a
9   -> i
10# -> j
26# -> z

Task 2: Goal Parser
Submitted by: Mohammad Sajid Anwar
You are given a string, $str.

Write a script to interpret the given string using Goal Parser.

The Goal Parser interprets “G” as the string “G”, “()” as the string “o”, and “(al)” as the string “al”. The interpreted strings are then concatenated in the original order.

Example 1
Input: $str = "G()(al)"
Output: "Goal"

G    -> "G"
()   -> "o"
(al) -> "al"

Example 2
Input: $str = "G()()()()(al)"
Output: "Gooooal"

G       -> "G"
four () -> "oooo"
(al)    -> "al"

Example 3
Input: $str = "(al)G(al)()()"
Output: "alGaloo"

(al) -> "al"
G    -> "G"
(al) -> "al"
()   -> "o"
()   -> "o"

Example 4
Input: $str = "()G()G"
Output: "oGoG"

() -> "o"
G  -> "G"
() -> "o"
G  -> "G"

Example 5
Input: $str = "(al)(al)G()()"
Output: "alalGoo"

(al) -> "al"
(al) -> "al"
G    -> "G"
()   -> "o"
()   -> "o"
