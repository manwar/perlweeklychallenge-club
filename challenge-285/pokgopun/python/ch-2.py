### https://theweeklychallenge.org/blog/perl-weekly-challenge-285/
"""

Task 2: Making Change

Submitted by: [50]David Ferrone
     __________________________________________________________________

   Compute the number of ways to make change for given amount in cents. By
   using the coins e.g. Penny, Nickel, Dime, Quarter and Half-dollar, in
   how many distinct ways can the total value equal to the given amount?
   Order of coin selection does not matter.
A penny (P) is equal to 1 cent.
A nickel (N) is equal to 5 cents.
A dime (D) is equal to 10 cents.
A quarter (Q) is equal to 25 cents.
A half-dollar (HD) is equal to 50 cents.

Example 1

Input: $amount = 9
Ouput: 2

1: 9P
2: N + 4P

Example 2

Input: $amount = 15
Ouput: 6

1: D + 5P
2: D + N
3: 3N
4: 2N + 5P
5: N + 10P
6: 15P

Example 3

Input: $amount = 100
Ouput: 292
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 8th September
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def mc(amount: int):
    c = 0
    for a50 in range(0,amount+1,50):
        for a25 in range(0,amount-a50+1,25):
            for a10 in range(0,amount-a50-a25+1,10):
                for a5 in range(0,amount-a50-a25-a10+1,5):
                    for a1 in range(0,amount-a50-a25-a10-a5+1,1):
                        if a50 + a25 + a10 + a5 + a1 == amount:
                            c += 1
    return c

import unittest

class TestMc(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                9: 2,
                15: 6,
                100: 292,
                }.items():
            self.assertEqual(mc(inpt),otpt)

unittest.main()
