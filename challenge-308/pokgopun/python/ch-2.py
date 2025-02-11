### https://theweeklychallenge.org/blog/perl-weekly-challenge-308/
"""

Task 2: Decode XOR

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an encoded array and an initial integer.

   Write a script to find the original array that produced the given
   encoded array. It was encoded such that encoded[i] = orig[i] XOR orig[i
   + 1].

Example 1

Input: @encoded = (1, 2, 3), $initial = 1
Output: (1, 0, 2, 1)

Encoded array created like below, if the original array was (1, 0, 2, 1)
$encoded[0] = (1 xor 0) = 1
$encoded[1] = (0 xor 2) = 2
$encoded[2] = (2 xor 1) = 3

Example 2

Input: @encoded = (6, 2, 7, 3), $initial = 4
Output: (4, 2, 0, 7, 4)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 16^th February
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def decodeXOR(enc: tuple[int], init: int) -> tuple[int]:
    l = len(enc)
    org = [0 for i in range(l+1)]
    org[0] = init
    for i in range(l):
        dst, src = enc[i], org[i] 
        if dst == src: ### a ^ o = a --> o = 0
            continue
        #print(i)
        if dst > src:
            dst, src = src, dst
        orgn = 0
        b = 1
        while dst > 0:
            orgn += b * abs(dst%2 - src%2)
            b *= 2
            dst //= 2
            src //= 2
        if src > 0:
            orgn += b * src
        org[i+1] = orgn
    return tuple(org)

import unittest

class TestDecodeXOR(unittest.TestCase):
    def test(self):
        for (enc, init), otpt in {
                ((1, 2, 3), 1): (1, 0, 2, 1),
                ((6, 2, 7, 3), 4): (4, 2, 0, 7, 4),
                }.items():
            #print(f'{enc}\n{otpt}')
            self.assertEqual(decodeXOR(enc, init), otpt)
 
unittest.main()
