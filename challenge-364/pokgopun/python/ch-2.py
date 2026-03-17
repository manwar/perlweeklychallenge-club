### https://theweeklychallenge.org/blog/perl-weekly-challenge-364/
"""

Task 2: Goal Parser

Submitted by: [66]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str.

   Write a script to interpret the given string using Goal Parser.

     The Goal Parser interprets “G” as the string “G”, “()” as the string
     “o”, and “(al)” as the string “al”. The interpreted strings are then
     concatenated in the original order.

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
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 15th March
"""
### solution by pokgopun@gmail.com

import re

pattern = re.compile(r"G|\(\)|\(al\)")

def goalParser(string: str) -> str:
    out = ""
    i = 0
    while True:
        m = pattern.search(string,i)
        if m == None:
            break
        match m.group(0):
            case "G":
                out += "G"
            case "()":
                out += "o"
            case "(al)":
                out += "al"
        i = m.span()[1]
    return out

import unittest

class TestGoalParser(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "G()(al)" : "Goal" ,
                "G()()()()(al)" : "Gooooal" ,
                "(al)G(al)()()" : "alGaloo" ,
                "()G()G" : "oGoG" ,
                "(al)(al)G()()" : "alalGoo",
                }.items():
            self.assertEqual(goalParser(inpt), otpt)

unittest.main()
