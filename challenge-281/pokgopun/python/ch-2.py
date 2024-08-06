### https://theweeklychallenge.org/blog/perl-weekly-challenge-281/
"""

Task 2: Knight’s Move

Submitted by: [48]Peter Campbell Smith
     __________________________________________________________________

   A Knight in chess can move from its current position to any square two
   rows or columns plus one column or row away. So in the diagram below,
   if it starts a S, it can move to any of the squares marked E.

   Write a script which takes a starting position and an ending position
   and calculates the least number of moves required.

   Week_281_Task_2

Example 1

Input: $start = 'g2', $end = 'a8'
Ouput: 4

g2 -> e3 -> d5 -> c7 -> a8

Example 2

Input: $start = 'g2', $end = 'h2'
Ouput: 3

g2 -> e3 -> f1 -> h2
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 11th August
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com
### https://afteracademy.com/blog/knight-on-chessboard/#:~:text=Solution,the%20shape%20of%20an%20L).

def pos2xy(string: str):
    return ord(string[0])-97, ord(string[1])-49

def xy2pos(x, y):
    return chr(97+x)+chr(49+y)

def isOnBoard(x, y):
    return x >=0 and x < 8 and y >= 0 and y < 8

def knightMove(start, end):
    XYd = ( (-2,-1), (-1,-2), ( 1,-2), ( 2,-1), (-2, 1), (-1, 2), ( 1, 2), ( 2, 1) )
    XYa = tuple([None for y in range(8)] for x in range(8))
    x0, y0 = pos2xy(start)
    x1, y1 = pos2xy(end)
    #XYa[x0][y0] = 0
    XYa[x0][y0] = ""
    XYq = [(x0, y0)]
    while len(XYq) > 0:
        x, y = XYq.pop(0)
        if (x,y) == (x1,y1):
            #return XYa[x][y]
            print(XYa[x][y]+end,"=>",int(len(XYa[x][y])/2))
            return int(len(XYa[x][y])/2)
        for dx, dy in XYd:
            xn, yn = x + dx, y + dy
            if isOnBoard(xn, yn) and XYa[xn][yn] is None:
                #XYa[xn][yn] = XYa[x][y] + 1
                XYa[xn][yn] = XYa[x][y] + xy2pos(x,y)
                XYq.append((xn,yn))
    return -1

import unittest

class TestKnightMove(unittest.TestCase):
    def test(self):
        for (start,end), count in {
                ('g2', 'a8'): 4,
                ('g2', 'h2'): 3,
                }.items():
            self.assertEqual(knightMove(start, end), count)

unittest.main()
