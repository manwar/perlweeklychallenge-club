Challenge 343
https://theweeklychallenge.org/blog/perl-weekly-challenge-343/

Task 1: Zero Friend
Submitted by: Mohammad Sajid Anwar
You are given a list of numbers.

Find the number that is closest to zero and return its distance to zero.


Example 1
Input: @nums = (4, 2, -1, 3, -2)
Output: 1

Values closest to 0: -1 and 2 (distance = 1 and 2)

Example 2
Input: @nums = (-5, 5, -3, 3, -1, 1)
Output: 1

Values closest to 0: -1 and 1 (distance = 1)

Example 3
Input: @ums = (7, -3, 0, 2, -8)
Output: 0

Values closest to 0: 0 (distance = 0)
Exact zero wins regardless of other close values.

Example 4
Input: @nums = (-2, -5, -1, -8)
Output: 1

Values closest to 0: -1 and -2 (distance = 1 and 2)

Example 5
Input: @nums = (-2, 2, -4, 4, -1, 1)
Output: 1

Values closest to 0: -1 and 1 (distance = 1)

Task 2: Champion Team
Submitted by: Mohammad Sajid Anwar
You have n teams in a tournament. A matrix grid tells you which team is stronger between any two teams:

If grid[i][j] == 1, then team i is stronger than team j
If grid[i][j] == 0, then team j is stronger than team i
Find the champion team - the one with most wins, or if there is no single such team, the strongest of the teams with most wins. (You may assume that there is a definite answer.)


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
