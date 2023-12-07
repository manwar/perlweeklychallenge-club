### https://theweeklychallenge.org/blog/perl-weekly-challenge-246/
"""

Task 1: 6 out of 49

Submitted by: [46]Andreas Voegele
     __________________________________________________________________

   6 out of 49 is a German lottery.

   Write a script that outputs six unique random integers from the range 1
   to 49.

Output

3
10
11
22
38
49

Task 2: Linear Recurrence of Second Order
"""
### solution by pokgopun@gmail.com

from random import sample

def GmLot():
    return sample(range(1,50),k=6)

import unittest

class TestGmLot(unittest.TestCase):
    def test1(self):
        self.assertEqual(len(GmLot()), 6, f"member count incorrect")
    def test2(self):
        for e in GmLot(): self.assertEqual( e in range(1,50), True, f"member not in range")
    def test3(self):
        self.assertEqual(len(set(GmLot())), 6, f"non-unique member found")
    def test4(self):
        lots = list()
        for i in range(100):
            lot = GmLot()
            self.assertEqual(lot not in lots, True, f"subsequent lot duplicated")
            lots.append(lot)

unittest.main()
