### https://theweeklychallenge.org/blog/perl-weekly-challenge-292/
"""

Task 2: Zuma Game

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a single row of colored balls, $row and a random number
   of colored balls in $hand.

   Here is the variation of Zuma game as your goal is to clear all of the
   balls from the board. Pick any ball from your hand and insert it in
   between two balls in the row or on either end of the row. If there is a
   group of three or more consecutive balls of the same color then remove
   the group of balls from the board. If there are no more balls on the
   board then you win the game. Repeat this process until you either win
   or do not have any more balls in your hand.

   Write a script to minimum number of balls you have to insert to clear
   all the balls from the board. If you cannot clear all the balls from
   the board using the balls in your hand, return -1.

Example 1

Input: $board = "WRRBBW", $hand = "RB"
Output: -1

It is impossible to clear all the balls. The best you can do is:
- Insert 'R' so the board becomes WRRRBBW. WRRRBBW -> WBBW.
- Insert 'B' so the board becomes WBBBW. WBBBW -> WW.
There are still balls remaining on the board, and you are out of balls to insert
.

Example 2

Input: $board = "WWRRBBWW", $hand = "WRBRW"
Output: 2

To make the board empty:
- Insert 'R' so the board becomes WWRRRBBWW. WWRRRBBWW -> WWBBWW.
- Insert 'B' so the board becomes WWBBBWW. WWBBBWW -> WWWW -> empty.
2 balls from your hand were needed to clear the board.

Example 3

Input: $board = "G", $hand = "GGGGG"
Output: 2

To make the board empty:
- Insert 'G' so the board becomes GG.
- Insert 'G' so the board becomes GGG. GGG -> empty.
2 balls from your hand were needed to clear the board.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 27th October
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from typing import TypeAlias,List,Tuple,Dict

class cluster:
    def __init__(self, color: str, count: int):
        self.color = color
        self.count = count

class Zuma:
    def __init__(self, board:str="", hand:str=""):
        self.board: List[cluster] = []
        clr = ""
        cnt = 0
        for c in board:
            if c == clr:
                cnt += 1
            else:
                if cnt > 0 and cnt < 3:
                    self.board.append(cluster(clr, cnt))
                clr = c
                cnt = 1
        if cnt > 0 and cnt < 3:
            self.board.append(cluster(clr, cnt))
        self.hand: Dict[str, int] = {}
        for c in hand:
            self.hand[c] = self.hand.get(c,0) + 1
    def clear(self, board:List[cluster], i:int) -> List[cluster]:
        l = len(board)
        if i >= l:
            return []
        if i == 0:
            return board[1:]
        if i == l-1:
            return board[:l-1]
        p = board[i-1]
        n = board[i+1]
        if p.color == n.color:
            if p.count + n.count > 2:
                return self.clear(board[:i-1] + board[i+1:], i-1)
            else:
                return board[:i-1] + [cluster(p.color, p.count + n.count)] + board[i+2:]
        return board[:i] + board[i+1:]
    def notdeadyet(self) -> bool:
        md: Dict[str, int] = {}
        for c in self.board:
            md[c.color] = c.count
        for k,v in md.items():
            if v + self.hand.get(k,0) < 3:
                return False
        return True
    def solve(self) -> int:
        l = len(self.board)
        if l == 0:
            return 0
        count = -1
        for i in range(l):
            cost = 3 - self.board[i].count
            if self.hand.get(self.board[i].color, 0) < cost:
                continue
            b = self.clear(self.board, i)
            h = self.hand.copy()
            h[self.board[i].color] -= cost
            z = Zuma()
            z.board = b
            z.hand = h
            if not z.notdeadyet():
                continue
            c = z.solve()
            if c < 0:
                continue
            if count < 0:
                count = cost + c
            else:
                count = min(count, cost + c)
        return count

import unittest

class TestZuma(unittest.TestCase):
    def test(self):
        for board, hand, count in (
                ("WRRBBW", "RB", -1),
                ("WWRRBBWW", "WRBRW", 2),
                ("G", "GGGGG", 2),
                ("WWRRWW", "RW", 1),
                ("GRGBGG", "RRBBG", 4),
                ("DAABABBDD", "DDCCBBAAA", 3),
                ):
            #print(board, hand, count)
            self.assertEqual(Zuma(board,hand).solve(), count)

unittest.main()
