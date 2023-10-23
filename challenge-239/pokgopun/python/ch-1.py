### https://theweeklychallenge.org/blog/perl-weekly-challenge-239/
"""

Task 1: Same String

Submitted by: [54]Mohammad S Anwar
     __________________________________________________________________

   You are given two arrays of strings.

   Write a script to find out if the word created by concatenating the
   array elements is the same.

Example 1

Input: @arr1 = ("ab", "c")
       @arr2 = ("a", "bc")
Output: true

Using @arr1, word1 => "ab" . "c" => "abc"
Using @arr2, word2 => "a" . "bc" => "abc"

Example 2

Input: @arr1 = ("ab", "c")
       @arr2 = ("ac", "b")
Output: false

Using @arr1, word1 => "ab" . "c" => "abc"
Using @arr2, word2 => "ac" . "b" => "acb"

Example 3

Input: @arr1 = ("ab", "cd", "e")
       @arr2 = ("abcde")
Output: true

Using @arr1, word1 => "ab" . "cd" . "e" => "abcde"
Using @arr2, word2 => "abcde"

Task 2: Consistent Strings
"""
### solution by pokgopun@gmail.com

def sameString(tot):
    return "".join(tot[0])=="".join(tot[1])

for inpt, otpt in {
        (("ab", "c"),("a", "bc")): True,
        (("ab", "c"),("ac", "b")): False,
        (("ab", "cd", "e"),("abcde")): True,
        }.items():
    print(sameString(inpt)==otpt)
