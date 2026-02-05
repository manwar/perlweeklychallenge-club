Challenge 348
https://theweeklychallenge.org/blog/perl-weekly-challenge-348/

Task 1: String Alike
Submitted by: Mohammad Sajid Anwar
You are given a string of even length.

Write a script to find out whether the given string can be split into two halves of equal lengths, each with the same non-zero number of vowels.


Example 1
Input: $str = "textbook"
Output: false

1st half: "text" (1 vowel)
2nd half: "book" (2 vowels)

Example 2
Input: $str = "book"
Output: true

1st half: "bo" (1 vowel)
2nd half: "ok" (1 vowel)

Example 3
Input: $str = "AbCdEfGh"
Output: true

1st half: "AbCd" (1 vowel)
2nd half: "EfGh" (1 vowel)

Example 4
Input: $str = "rhythmmyth"
Output: false

1st half: "rhyth" (0 vowel)
2nd half: "mmyth" (0 vowel)

Example 5
Input: $str = "UmpireeAudio"
Output: false

1st half: "Umpire" (3 vowels)
2nd half: "eAudio" (5 vowels)

Task 2: Covert Time
Submitted by: Mohammad Sajid Anwar
You are given two strings, $source and $target, containing time in 24-hour time form.

Write a script to convert the source into target by performing one of the following operations:

1. Add  1 minute
2. Add  5 minutes
3. Add 15 minutes
4. Add 60 minutes
Find the total operations needed to get to the target.


Example 1
Input: $source = "02:30"
       $target = "02:45"
Output: 1

Just one operation i.e. "Add 15 minutes".

Example 2
Input: $source = "11:55"
       $target = "12:15"
Output: 2

Two operations i.e. "Add 15 minutes" followed by "Add 5 minutes".

Example 3
Input: $source = "09:00"
       $target = "13:00"
Output: 4

Four operations of "Add 60 minutes".

Example 4
Input: $source = "23:45"
       $target = "00:30"
Output: 3

Three operations of "Add 15 minutes".

Example 5
Input: $source = "14:20"
       $target = "15:25"
Output: 2

Two operations, one "Add 60 minutes" and one "Add 5 minutes"
