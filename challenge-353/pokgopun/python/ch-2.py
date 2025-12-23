### https://theweeklychallenge.org/blog/perl-weekly-challenge-353/
"""

Task 2: Validate Coupon

Submitted by: [74]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given three arrays, @codes, @names and @status.

   Write a script to validate codes in the given array.
A code is valid when the following conditions are true:
- codes[i] is non-empty and consists only of alphanumeric characters (a-z, A-Z,
0-9) and underscores (_).
- names[i] is one of the following four categories: "electronics", "grocery", "p
harmacy", "restaurant".
- status[i] is true.

   Return an array of booleans indicating validity: output[i] is true if
   and only if codes[i], names[i] and status[i] are all valid.

Example 1

Input: @codes  = ("A123", "B_456", "C789", "D@1", "E123")
       @names  = ("electronics", "restaurant", "electronics", "pharmacy", "groce
ry")
       @status = ("true", "false", "true", "true", "true")
Output: (true, false, true, false, true)

Example 2

Input: @codes  = ("Z_9", "AB_12", "G01", "X99", "test")
       @names  = ("pharmacy", "electronics", "grocery", "electronics", "unknown"
)
       @status = ("true", "true", "false", "true", "true")
Output: (true, true, false, true, false)

Example 3

Input: @codes  = ("_123", "123", "", "Coupon_A", "Alpha")
       @names  = ("restaurant", "electronics", "electronics", "pharmacy", "groce
ry")
       @status = ("true", "true", "false", "true", "true")
Output: (true, true, false, true, true)

Example 4

Input: @codes  = ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4")
       @names  = ("electronics", "electronics", "grocery", "grocery")
       @status = ("true", "true", "true", "true")
Output: (true, true, true, true)

Example 5

Input: @codes  = ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99")
       @names  = ("restaurant", "electronics", "grocery", "pharmacy", "electroni
cs")
       @status = ("true", "true", "true", "true", "false")
Output: (true, true, true, true, false)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 28th December
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

import re

def validateCoupon(codes: tuple[str], names: tuple[str], status: tuple[str]) -> tuple[bool]:
    return tuple(
            status[i] == "true" and 
            names[i] in ("electronics", "grocery", "pharmacy", "restaurant") and 
            re.fullmatch(r"\w+",codes[i]) is not None
            for i in range(len(codes))
            )

import unittest

class TestValidateCoupon(unittest.TestCase):
    def test(self):
        for (codes, names, status),  otpt in {
                (
                    ("A123", "B_456", "C789", "D@1", "E123"),
                    ("electronics", "restaurant", "electronics", "pharmacy", "grocery"),
                    ("true", "false", "true", "true", "true"),
                    ): (True, False, True, False, True),
                (
                    ("Z_9", "AB_12", "G01", "X99", "test"),
                    ("pharmacy", "electronics", "grocery", "electronics", "unknown"),
                    ("true", "true", "false", "true", "true"),
                    ): (True, True, False, True, False),
                (
                    ("_123", "123", "", "Coupon_A", "Alpha"),
                    ("restaurant", "electronics", "electronics", "pharmacy", "grocery"),
                    ("true", "true", "False", "true", "true"),
                    ): (True, True, False, True, True),
                (
                    ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"),
                    ("electronics", "electronics", "grocery", "grocery"),
                    ("true", "true", "true", "true"),
                    ): (True, True, True, True),
                (
                    ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"),
                    ("restaurant", "electronics", "grocery", "pharmacy", "electronics"),
                    ("true", "true", "true", "true", "false"),
                    ): (True, True, True, True, False),
                }.items():
            self.assertEqual(validateCoupon(codes,names,status), otpt)

unittest.main()
