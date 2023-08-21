# https://theweeklychallenge.org/blog/perl-weekly-challenge-230/
"""
Task 2: Count Words
Submitted by: Mohammad S Anwar
You are given an array of words made up of alphabetic characters and a prefix.

Write a script to return the count of words that starts with the given prefix.

Example 1
Input: @words  = ("pay", "attention", "practice", "attend")
       $prefix = "at"
Ouput: 2

Two words "attention" and "attend" starts with the given prefix "at".
Example 2
Input: @words  = ("janet", "julia", "java", "javascript")
       $prefix = "ja"
Ouput: 3

Three words "janet", "java" and "javascripr" starts with the given prefix "ja".
"""

def countMatchPrefix( lst, prefix ): return len(tuple(filter(lambda x: x.startswith(prefix), lst )))

for lst, prefix,count in (
        (("pay", "attention", "practice", "attend"), "at", 2),
        (("janet", "julia", "java", "javascript"), "ja", 3),
        ):
    print(countMatchPrefix(lst, prefix)==count)
