### https://theweeklychallenge.org/blog/perl-weekly-challenge-239/
"""

Task 2: Consistent Strings

Submitted by: [55]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of strings and allowed string having distinct
   characters.

     A string is consistent if all characters in the string appear in the
     string allowed.

   Write a script to return the number of consistent strings in the given
   array.

Example 1

Input: @str = ("ad", "bd", "aaab", "baa", "badab")
       $allowed = "ab"
Output: 2

Strings "aaab" and "baa" are consistent since they only contain characters 'a' a
nd 'b'.

Example 2

Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
       $allowed = "abc"
Output: 7

Example 3

Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
       $allowed = "cad"
Output: 4

Strings "cc", "acd", "ac", and "d" are consistent.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 22nd October
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def cnsstntStrings(tup, allowed):
    allowedChrs = set(bytes(allowed,"ascii"))
    return len(
            tuple(
                filter(
                    lambda x: set(bytes(x,"ascii")).issubset(allowedChrs),
                    tup
                    )
                )
            )

for (inpt1, inpt2), otpt in {
        (("ad", "bd", "aaab", "baa", "badab"), "ab"): 2,
        (("a", "b", "c", "ab", "ac", "bc", "abc"), "abc"): 7,
        (("cc", "acd", "b", "ba", "bac", "bad", "ac", "d"), "cad"): 4,
        }.items():
    print(cnsstntStrings(inpt1,inpt2)==otpt)

