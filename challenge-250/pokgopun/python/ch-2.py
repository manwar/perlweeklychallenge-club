### https://theweeklychallenge.org/blog/perl-weekly-challenge-250/
"""

Task 2: Alphanumeric String Value

Submitted by: [39]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of alphanumeric strings.

   Write a script to return the maximum value of alphanumeric string in
   the given array.

   The value of alphanumeric string can be defined as
a) The numeric representation of the string in base 10 if it is made up of digit
s only.
b) otherwise the length of the string

Example 1

Input: @alphanumstr = ("perl", "2", "000", "python", "r4ku")
Output: 6

"perl" consists of letters only so the value is 4.
"2" is digits only so the value is 2.
"000" is digits only so the value is 0.
"python" consits of letters so the value is 6.
"r4ku" consists of letters and digits so the value is 4.

Example 2

Input: @alphanumstr = ("001", "1", "000", "0001")
Output: 1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 7th January
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def alphanumericStringValue(tup: tuple):
    return max(
            int(e) if e.isnumeric() else len(e) for e in tup
            )

import unittest

class TestAlphanumericStringValue(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                ("perl", "2", "000", "python", "r4ku"): 6,
                ("001", "1", "000", "0001"): 1,
                }.items():
            self.assertEqual(alphanumericStringValue(inpt),otpt)

unittest.main()
 
