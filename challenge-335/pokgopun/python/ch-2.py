### https://theweeklychallenge.org/blog/perl-weekly-challenge-335/
"""

Task 2: Find Winner

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of all moves by the two players.

   Write a script to find the winner of the TicTacToe game if found based
   on the moves provided in the given array.

Example 1

Input: @moves = ([0,0],[2,0],[1,1],[2,1],[2,2])
Output: A

Game Board:
[ A _ _ ]
[ B A B ]
[ _ _ A ]

Example 2

Input: @moves = ([0,0],[1,1],[0,1],[0,2],[1,0],[2,0])
Output: B

Game Board:
[ A A B ]
[ A B _ ]
[ B _ _ ]

Example 3

Input: @moves = ([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2])
Output: Draw

Game Board:
[ A A B ]
[ B B A ]
[ A B A ]

Example 4

Input: @moves = ([0,0],[1,1])
Output: Pending

Game Board:
[ A _ _ ]
[ _ B _ ]
[ _ _ _ ]

Example 5

Input: @moves = ([1,1],[0,0],[2,2],[0,1],[1,0],[0,2])
Output: B

Game Board:
[ B B B ]
[ A A _ ]
[ _ _ A ]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 25th August
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def fw(moves: tuple[tuple[int]]) -> str:
    m2s: dict[tuple[int],int] = {}
    for i in range(len(moves)):
        m2s[moves[i]] = (-1)**(i % 2)
    res = "Draw"
    scores: list[list[int]] = []
    scoredd: list[int] = []
    scoreda: list[int] = []
    for i in range(3):
        scores.extend((
                    list(m2s.get((i,e),0) for e in range(3)),
                    list(m2s.get((e,i),0) for e in range(3)),
                ))
        scoredd.append(m2s.get((i,i),0))
        scoreda.append(m2s.get((i,2-i),0))
    for score in scores + [scoredd,scoreda]:
        if score.count(0) > 1:
            res = "Pending"
            continue
        match sum(score):
            case 3:
                return "A"
            case -3:
                return "B"
            case 2,-2:
                res = "Pending"
    return res

import unittest

class TestFw(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                ((0,0),(2,0),(1,1),(2,1),(2,2)): "A",
                ((0,0),(1,1),(0,1),(0,2),(1,0),(2,0)): "B",
                ((0,0),(1,1),(2,0),(1,0),(1,2),(2,1),(0,1),(0,2),(2,2)): "Draw",
                ((0,0),(1,1)): "Pending",
                ((1,1),(0,0),(2,2),(0,1),(1,0),(0,2)): "B",
                }.items():
            self.assertEqual(fw(inpt),otpt)

unittest.main()
