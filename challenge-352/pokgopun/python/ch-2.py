### https://theweeklychallenge.org/blog/perl-weekly-challenge-352/
"""

Task 2: Binary Prefix

Submitted by: [68]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array, @nums, where each element is either 0 or 1.

   Define x[i] as the number formed by taking the first i+1 bits of @nums
   (from $nums[0] to $nums[i]) and interpreting them as a binary number,
   with $nums[0] being the most significant bit.

   For example:
If @nums = (1, 0, 1), then:

x0 = 1 (binary 1)
x1 = 2 (binary 10)
x2 = 5 (binary 101)

For each i, check whether xi is divisible by 5.

   Write a script to return an array @answer where $answer[i] is true if
   x<sub>i</sub> is divisible by 5, otherwise false.

Example 1

Input: @nums = (0,1,1,0,0,1,0,1,1,1)
Output: (true, false, false, false, false, true, true, false, false, false)

Binary numbers formed (decimal values):
         0: 0
        01: 1
       011: 3
      0110: 6
     01100: 12
    011001: 25
   0110010: 50
  01100101: 101
 011001011: 203
0110010111: 407

Example 2

Input: @num = (1,0,1,0,1,0)
Output: (false, false, true, true, false, false)

     1: 1
    10: 2
   101: 5
  1010: 10
 10101: 21
101010: 42

Example 3

Input: @num = (0,0,1,0,1)
Output: (true, true, false, false, true)

    0: 0
   00: 0
  001: 1
 0010: 2
00101: 5

Example 4

Input: @num = (1,1,1,1,1)
Output: (false, false, false, true, false)

    1: 1
   11: 3
  111: 7
 1111: 15
11111: 31

Example 5

Input: @num = (1,0,1,1,0,1,0,0,1,1)
Output: (false, false, true, false, false, true, true, true, false, false)

         1: 1
        10: 2
       101: 5
      1011: 11
     10110: 22
    101101: 45
   1011010: 90
  10110100: 180
 101101001: 361
1011010011: 723
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 21st December
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def bp(num: tuple[int]) -> tuple[bool]:
    #return tuple(int("".join(str(n) for n in num[:i+1]) % 5 == 0), for i in range(len(num)))
    sm = int("".join(str(n) for n in num),2)
    out = []
    l = len(num)
    while l > 0:
        out.insert(0, sm % 5 == 0)
        sm //= 2
        l -= 1
    return tuple(out)

import unittest

class TestBp(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (0,1,1,0,0,1,0,1,1,1): (True, False, False, False, False, True, True, False, False, False),
                (1,0,1,0,1,0): (False, False, True, True, False, False),
                (0,0,1,0,1): (True, True, False, False, True),
                (1,1,1,1,1): (False, False, False, True, False),
                (1,0,1,1,0,1,0,0,1,1): (False, False, True, False, False, True, True, True, False, False),
                }.items():
            self.assertEqual(bp(inpt), otpt)

unittest.main()
