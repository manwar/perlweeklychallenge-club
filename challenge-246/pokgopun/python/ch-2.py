### https://theweeklychallenge.org/blog/perl-weekly-challenge-246/
"""

Task 2: Linear Recurrence of Second Order

Submitted by: [47]Jorg Sommrey
     __________________________________________________________________

   You are given an array @a of five integers.

   Write a script to decide whether the given integers form a linear
   recurrence of second order with integer factors.

   A linear recurrence of second order has the form
a[n] = p * a[n-2] + q * a[n-1] with n > 1

where p and q must be integers.

Example 1

Input: @a = (1, 1, 2, 3, 5)
Output: true

@a is the initial part of the Fibonacci sequence a[n] = a[n-2] + a[n-1]
with a[0] = 1 and a[1] = 1.

Example 2

Input: @a = (4, 2, 4, 5, 7)
Output: false

a[1] and a[2] are even. Any linear combination of two even numbers with integer
factors is even, too.
Because a[3] is odd, the given numbers cannot form a linear recurrence of second
 order with integer factors.

Example 3

Input: @a = (4, 1, 2, -3, 8)
Output: true

a[n] = a[n-2] - 2 * a[n-1]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 10th December
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

class Seq3:
    def __init__(self, ints :tuple):
        ## a*p + b*q = c
        self.a, self.b, self.c = ( ints[i:i+3] for i in range(3) )
        self.is_lroso = None
        self.ans = set()
        self.process()
    def set_lroso(self, b :bool):
        if self.is_lroso is None:
            self.is_lroso = b
    def process(self):
        for i,j in ( (i,i+1) for i in range(2) ):   ## process pair of seq3
            ## eliminate p from equation to get q = dvd/dvs
            dvd, dvs = self.a[j]*self.c[i] - self.a[i]*self.c[j], self.a[j]*self.b[i] - self.a[i]*self.b[j]
            if dvd % dvs != 0:   ## if q is not int, set is_lroso to false
                self.set_lroso(False)
            q = dvd/dvs
            ## replace q in equation to get p = dvd/dvs
            dvd, dvs = self.c[i] - self.b[i]*q, self.a[i]
            if dvd % dvs != 0:   ## if p is not int, set is_lroso to false
                self.set_lroso(False)
            p = dvd/dvs
            self.ans.add((p,q))   ## store p,q to ans
        if len(self.ans) > 1:   ## if there multiple answers, set is_lroso to false
            self.set_lroso(False)
        self.set_lroso(True)   ## otherwise, set is_lroso to true

import unittest

class TestSeq3(unittest.TestCase):
    def test1(self):
        self.assertEqual(Seq3((1, 1, 2, 3, 5)).is_lroso, True,"Ex1")
    def test2(self):
        self.assertEqual(Seq3((4, 2, 4, 5, 7)).is_lroso, False,"Ex2")
    def test3(self):
        self.assertEqual(Seq3((4, 1, 2, -3, 8)).is_lroso, True,"Ex3")

unittest.main()
