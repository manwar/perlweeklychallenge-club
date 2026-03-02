Challenge 292
https://theweeklychallenge.org/blog/perl-weekly-challenge-292/

Task 1: Twice Largest
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints, where the largest integer is unique.

Write a script to find whether the largest element in the array is at least twice as big as every element in the given array. If it is return the index of the largest element or return -1 otherwise.

Example 1
Input: @ints = (2, 4, 1, 0)
Output: 1

The largest integer is 4.
For every other elements in the given array is at least twice as big.
The index value of 4 is 1.
Example 2
Input: @ints = (1, 2, 3, 4)
Output: -1

The largest integer is 4.
4 is less than twice the value of 3, so we return -1.

Task 2: Zuma Game
Submitted by: Mohammad Sajid Anwar
You are given a single row of colored balls, $row and a random number of colored balls in $hand.

Here is the variation of Zuma game as your goal is to clear all of the balls from the board. Pick any ball from your hand and insert it in between two balls in the row or on either end of the row. If there is a group of three or more consecutive balls of the same color then remove the group of balls from the board. If there are no more balls on the board then you win the game. Repeat this process until you either win or do not have any more balls in your hand.

Write a script to minimum number of balls you have to insert to clear all the balls from the board. If you cannot clear all the balls from the board using the balls in your hand, return -1.

Example 1
Input: $board = "WRRBBW", $hand = "RB"
Output: -1

It is impossible to clear all the balls. The best you can do is:
- Insert 'R' so the board becomes WRRRBBW. WRRRBBW -> WBBW.
- Insert 'B' so the board becomes WBBBW. WBBBW -> WW.
There are still balls remaining on the board, and you are out of balls to insert.
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
