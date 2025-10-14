### https://theweeklychallenge.org/blog/perl-weekly-challenge-343/
"""

Task 2: Champion Team

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You have n teams in a tournament. A matrix grid tells you which team is
   stronger between any two teams:
If grid[i][j] == 1, then team i is stronger than team j
If grid[i][j] == 0, then team j is stronger than team i

   Find the champion team - the one with most wins, or if there is no
   single such team, the strongest of the teams with most wins. (You may
   assume that there is a definite answer.)

Example 1

Input: @grid = (
                 [0, 1, 1],
                 [0, 0, 1],
                 [0, 0, 0],
               )
Output: Team 0

[0, 1, 1] => Team 0 beats Team 1 and Team 2
[0, 0, 1] => Team 1 beats Team 2
[0, 0, 0] => Team 2 loses to all

Example 2

Input: @grid = (
                 [0, 1, 0, 0],
                 [0, 0, 0, 0],
                 [1, 1, 0, 0],
                 [1, 1, 1, 0],
               )
Output: Team 3

[0, 1, 0, 0] => Team 0 beats only Team 1
[0, 0, 0, 0] => Team 1 loses to all
[1, 1, 0, 0] => Team 2 beats Team 0 and Team 1
[1, 1, 1, 0] => Team 3 beats everyone

Example 3

Input: @grid = (
                 [0, 1, 0, 1],
                 [0, 0, 1, 1],
                 [1, 0, 0, 0],
                 [0, 0, 1, 0],
               )
Output: Team 0

[0, 1, 0, 1] => Team 0 beats teams 1 and 3
[0, 0, 1, 1] => Team 1 beats teams 2 and 3
[1, 0, 0, 0] => Team 2 beats team 0
[0, 0, 1, 0] => Team 3 beats team 2

Of the teams with 2 wins, Team 0 beats team 1.

Example 4

Input: @grid = (
                 [0, 1, 1],
                 [0, 0, 0],
                 [0, 1, 0],
               )
Output: Team 0

[0, 1, 1] => Team 0 beats Team 1 and Team 2
[0, 0, 0] => Team 1 loses to Team 2
[0, 1, 0] => Team 2 beats Team 1 but loses to Team 0

Example 5

Input: @grid = (
                 [0, 0, 0, 0, 0],
                 [1, 0, 0, 0, 0],
                 [1, 1, 0, 1, 1],
                 [1, 1, 0, 0, 0],
                 [1, 1, 0, 1, 0],
               )
Output: Team 2

[0, 0, 0, 0, 0] => Team 0 loses to all
[1, 0, 0, 0, 0] => Team 1 beats only Team 0
[1, 1, 0, 1, 1] => Team 2 beats everyone except self
[1, 1, 0, 0, 0] => Team 3 loses to Team 2
[1, 1, 0, 1, 0] => Team 4 loses to Team 2
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 19th October
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def ct(grid: list[list[int]]) -> int:
    ranks = sorted((sum(grid[i]),i) for i in range(len(grid)))   ### list of tup where tup[1] is team_id and tup[0] is win count, asc sorted by win count
    mx = ranks[-1][0]                                           ### max win count
    top_ids = [ e[1] for e in ranks if e[0] == mx ]                ### list of top team_id that have max win cout
    l = len(top_ids)
    if l == 1:                                           ### if only one team_id in the top team_id, return the team_id 
        return top_ids[0]
    for i in range(l-1):
        for j in range(i+1,l):
            a, b = top_ids[i], top_ids[j]
            if grid[a][b] == 1:
                return a
            if grid[b][a] == 1:
                return b
    return None                                                  ### top teams cannot win each other

import unittest

class TestCt(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (
                 (0, 1, 1),
                 (0, 0, 1),
                 (0, 0, 0),
               ): 0,
                (
                 (0, 1, 0, 0),
                 (0, 0, 0, 0),
                 (1, 1, 0, 0),
                 (1, 1, 1, 0),
               ): 3,
                (
                 (0, 1, 0, 1),
                 (0, 0, 1, 1),
                 (1, 0, 0, 0),
                 (0, 0, 1, 0),
               ): 0,
                (
                 (0, 1, 1),
                 (0, 0, 0),
                 (0, 1, 0),
               ): 0,
                (
                 (0, 0, 0, 0, 0),
                 (1, 0, 0, 0, 0),
                 (1, 1, 0, 1, 1),
                 (1, 1, 0, 0, 0),
                 (1, 1, 0, 1, 0),
               ): 2,
                }.items():
            self.assertEqual(ct(inpt), otpt)

unittest.main()
