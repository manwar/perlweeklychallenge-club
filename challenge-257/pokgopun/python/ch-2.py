### https://theweeklychallenge.org/blog/perl-weekly-challenge-257/
"""

Task 2: Reduced Row Echelon

Submitted by: [45]Ali Moradi
     __________________________________________________________________

   Given a matrix M, check whether the matrix is in reduced row echelon
   form.

   A matrix must have the following properties to be in reduced row
   echelon form:
1. If a row does not consist entirely of zeros, then the first
   nonzero number in the row is a 1. We call this the leading 1.
2. If there are any rows that consist entirely of zeros, then
   they are grouped together at the bottom of the matrix.
3. In any two successive rows that do not consist entirely of zeros,
   the leading 1 in the lower row occurs farther to the right than
   the leading 1 in the higher row.
4. Each column that contains a leading 1 has zeros everywhere else
   in that column.

   For example:
[
   [1,0,0,1],
   [0,1,0,2],
   [0,0,1,3]
]

   The above matrix is in reduced row echelon form since the first nonzero
   number in each row is a 1, leading 1s in each successive row are
   farther to the right, and above and below each leading 1 there are only
   zeros.

   For more information check out this wikipedia [46]article.

Example 1

    Input: $M = [
                  [1, 1, 0],
                  [0, 1, 0],
                  [0, 0, 0]
                ]
    Output: 0

Example 2

    Input: $M = [
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
                ]
    Output: 1

Example 3

    Input: $M = [
                  [1, 0, 0, 4],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
                ]
    Output: 1

Example 4

    Input: $M = [
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0]
                ]
    Output: 0

Example 5

    Input: $M = [
                  [0, 1, 0],
                  [1, 0, 0],
                  [0, 0, 0]
                ]
    Output: 0

Example 6

    Input: $M = [
                  [4, 0, 0, 0],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
                ]
    Output: 0
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 25th February
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def areAllZeroes(tup: tuple):   ### check if all members are zeros
    return sum( x!=0 for x in tup )==0

def genNZ(tot: tuple):   ### remove bottom all-zeroes rows, return others rows in reverse
    c = 0
    l = len(tot)
    for i in range(l):
        if areAllZeroes(tot[l-i-1]):
            c += 1
            if c > i:
                continue
        yield tot[l-i-1]

def lopos(tup: tuple):   ### position of leading 1, return -1 if there is no leadnig 1
    for i in range(len(tup)):
        if tup[i]==1:
            return i
    return -1

def isRRE(tot: tuple):   ### check if matrix is Reduced Row Echelon
    l = len(tot[0])    ### to store previous leading 1 position, as we will do it in backward, initial value will be the row length which is always greater than any position
    tot = tuple(genNZ(tot))   ### matrix with bottom all-zeroes rows removed, but the rows will be reversed
    rc = len(tot)             ### row count, this will be used by list comprehension that check if same columns as the leading 1 are all zeros or not
    for t in tot:
        lp = lopos(t)   ### find out the poistion of leading 1
        if lp <  0 or lp >= l or sum(tot[r][lp]==0 for r in range(rc))!=rc-1:   ### False if leading 1 cannot be found or its position is not less than the previous one or other values in its postions are not all zeros
            return False
        l = lp 
    return True

import unittest

class TestIsRRE(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                (
                  (1, 1, 0),
                  (0, 1, 0),
                  (0, 0, 0)
                ): 0,
                (
                  (0, 1,-2, 0, 1),
                  (0, 0, 0, 1, 3),
                  (0, 0, 0, 0, 0),
                  (0, 0, 0, 0, 0)
                ): 1,
                (
                  (1, 0, 0, 4),
                  (0, 1, 0, 7),
                  (0, 0, 1,-1)
                ): 1,
                (
                  (0, 1,-2, 0, 1),
                  (0, 0, 0, 0, 0),
                  (0, 0, 0, 1, 3),
                  (0, 0, 0, 0, 0)
                ): 0,
                (
                  (0, 1, 0),
                  (1, 0, 0),
                  (0, 0, 0)
                ): 0,
                (
                  (4, 0, 0, 0),
                  (0, 1, 0, 7),
                  (0, 0, 1,-1)
                ): 0,
                }.items():
            self.assertEqual(isRRE(inpt),otpt)

unittest.main()
