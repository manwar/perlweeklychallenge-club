Perl Weekly Challenge 370
https://theweeklychallenge.org/blog/perl-weekly-challenge-370/

Task 1: Popular Word
Submitted by: Mohammad Sajid Anwar
You are given a string paragraph and an array of the banned words.

Write a script to return the most popular word that is not banned. It is guaranteed there is at least one word that is not banned and the answer is unique. The words in paragraph are case-insensitive and the answer should be in lowercase. The words can not contain punctuation symbols.

Example 1
Input: $paragraph = "Bob hit a ball, the hit BALL flew far after it was hit."
       @banned = ("hit")
Output: "ball"

After removing punctuation and converting to lowercase, the word "hit" appears 3 times, and "ball" appears 2 times.
Since "hit" is on the banned list, we ignore it.

Example 2
Input: $paragraph = "Apple? apple! Apple, pear, orange, pear, apple, orange."
       @banned = ("apple", "pear")
Output: "orange"

"apple"  appears 4 times.
"pear"   appears 2 times.
"orange" appears 2 times.

"apple" and "pear" are both banned.
Even though "orange" has the same frequency as "pear", it is the only non-banned word with the highest frequency.

Example 3
Input: $paragraph = "A. a, a! A. B. b. b."
       @banned = ("b")
Output: "a"

"a" appears 4 times.
"b" appears 3 times.

The input has mixed casing and heavy punctuation.
The normalised, "a" is the clear winner, since "b" is banned, "a" is the only choice.

Example 4
Input: $paragraph = "Ball.ball,ball:apple!apple.banana"
       @banned = ("ball")
Output: "apple"

Here the punctuation acts as a delimiter.
"ball"   appears 3 times.
"apple"  appears 2 times.
"banana" appears 1 time.

Example 5
Input: $paragraph = "The dog chased the cat, but the dog was faster than the cat."
       @banned = ("the", "dog")
Output: "cat"

"the" appears 4 times.
"dog" appears 2 times.
"cat" appears 2 times.

"chased", "but", "was", "faster", "than" appear 1 time each.
"the" is the most frequent but is banned.
"dog" is the next most frequent but is also banned.
The next most frequent non-banned word is "cat".

Task 2: Scramble String
Submitted by: Roger Bell_West
You are given two strings A and B of the same length.

Write a script to return true if string B is a scramble of string A otherwise return false.

String B is a scramble of string A if A can be transformed into B by a single (recursive) scramble operation.

A scramble operation is:

- If the string consists of only one character, return the string.
- Divide the string X into two non-empty parts.
- Optionally, exchange the order of those parts.
- Optionally, scramble each of those parts.
- Concatenate the scrambled parts to return a single string.

Example 1
Input: $str1 = "abc", $str2 = "acb"
Output: true

"abc"
split: ["a", "bc"]
split: ["a", ["b", "c"]]
swap: ["a", ["c", "b"]]
concatenate: "acb"

Example 2
Input: $str1 = "abcd", $str2 = "cdba"
Output: true

"abcd"
split: ["ab", "cd"]
swap: ["cd", "ab"]
split: ["cd", ["a", "b"]]
swap: ["cd", ["b", "a"]]
concatenate: "cdba"

Example 3
Input: $str1 = "hello", $str2 = "hiiii"
Output: false

A fundamental rule of scrambled strings is that they must be anagrams.

Example 4
Input: $str1 = "ateer", $str2 = "eater"
Output: true

"ateer"
split: ["ate", "er"]
split: [["at", "e"], "er"]
swap: [["e", "at"], "er"]
concatenate: "eater"

Example 5
Input: $str1 = "abcd", $str2 = "bdac"
Output: false
