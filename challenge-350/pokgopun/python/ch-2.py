### https://theweeklychallenge.org/blog/perl-weekly-challenge-350/
"""

Task 2: Shuffle Pairs

Submitted by: [52]E. Choroba
     __________________________________________________________________

   If two integers A <= B have the same digits but in different orders, we
   say that they belong to the same shuffle pair if and only if there is
   an integer k such that A = B * k. k is called the witness of the pair.

   For example, 1359 and 9513 belong to the same shuffle pair, because
   1359 * 7 = 9513.

   Interestingly, some integers belong to several different shuffle pairs.
   For example, 123876 forms one shuffle pair with 371628, and another
   with 867132, as 123876 * 3 = 371628, and 123876 * 7 = 867132.

   Write a function that for a given $from, $to, and $count returns the
   number of integers $i in the range $from <= $i <= $to that belong to at
   least $count different shuffle pairs.

   PS: Inspired by a conversation between Mark Dominus and Simon Tatham at
   Mastodon.

Example 1

Input: $from = 1, $to = 1000, $count = 1
Output: 0

There are no shuffle pairs with elements less than 1000.

Example 2

Input: $from = 1500, $to = 2500, $count = 1
Output: 3

There are 3 integers between 1500 and 2500 that belong to shuffle pairs.

1782, the other element is 7128 (witness 4)
2178, the other element is 8712 (witness 4)
2475, the other element is 7425 (witness 3)

Example 3

Input: $from = 1_000_000, $to = 1_500_000, $count = 5
Output: 2

There are 2 integers in the given range that belong to 5 different shuffle pairs
.

1428570 pairs with 2857140, 4285710, 5714280, 7142850, and 8571420
1429857 pairs with 2859714, 4289571, 5719428, 7149285, and 8579142

The witnesses are 2, 3, 4, 5, and 6 for both the integers.

Example 4

Input: $from = 13_427_000, $to = 14_100_000, $count = 2
Output: 11

6 integers in the given range belong to 3 different shuffle pairs, 5 integers be
long to 2 different ones.

Example 5

Input: $from = 1030, $to = 1130, $count = 1
Output: 2

There are 2 integers between 1020 and 1120 that belong to at least one shuffle p
air:
1035, the other element is 3105 (witness k = 3)
1089, the other element is 9801 (witness k = 9)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 7th December
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def dgt2sig(n: int) -> list[int]:
    lst = sorted(str(n),reverse=True)
    prv = lst[0]
    s = []
    cnt = 1
    for v in lst[1:]:
        if v != prv:
            s.append(prv)
            s.append(cnt)
            cnt = 0
            prv = v
        else:
            cnt += 1
    s.append(prv)
    s.append(cnt)
    return s

def isShufflePair(n: int, count: int) -> bool:
    sig0 = dgt2sig(n)
    u = int("".join(sorted(str(n),reverse=True)))
    l = u // n
    m = n
    c = 0
    while l > count - c:
        l -= 1
        m += n
        if dgt2sig(m) == sig0:
            c += 1
        if c == count:
            return True
    return False

def sp(llmt: int, ulmt: int, count: int) -> int:
    c = 0
    for n in range(llmt,ulmt+1):
        if isShufflePair(n, count):
            c += 1
    return c

import unittest

class TestSp(unittest.TestCase):
    def test(self):
        for (llmt, ulmt, count), otpt in {
                (1, 1000, 1): 0,
                (1500, 2500, 1): 3,
                (1_000_000, 1_500_000, 5): 2,
                (13_427_000, 14_100_000, 2): 11,
                (1030, 1130, 1): 2,
                }.items():
            self.assertEqual(sp(llmt,ulmt,count),otpt)

unittest.main()
