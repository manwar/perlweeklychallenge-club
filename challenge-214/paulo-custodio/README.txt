Perl Weekly Challenge 214
https://theweeklychallenge.org/blog/perl-weekly-challenge-214/

Task 1: Rank Score
Submitted by: Mohammad S Anwar
You are given a list of scores (>=1).

Write a script to rank each score in descending order. First three will get medals i.e. G (Gold), S (Silver) and B (Bronze). Rest will just get the ranking number.

Using the standard model of giving equal scores equal rank, then advancing that number of ranks.


Example 1
Input: @scores = (1,2,4,3,5)
Output: (5,4,S,B,G)

Score 1 is the 5th rank.
Score 2 is the 4th rank.
Score 4 is the 2nd rank i.e. Silver (S).
Score 3 is the 3rd rank i.e. Bronze (B).
Score 5 is the 1st rank i.e. Gold (G).

Example 2
Input: @scores = (8,5,6,7,4)
Output: (G,4,B,S,5)

Score 8 is the 1st rank i.e. Gold (G).
Score 4 is the 4th rank.
Score 6 is the 3rd rank i.e. Bronze (B).
Score 7 is the 2nd rank i.e. Silver (S).
Score 4 is the 5th rank.

Example 3
Input: @list = (3,5,4,2)
Output: (B,G,S,4)

Example 4
Input: @scores = (2,5,2,1,7,5,1)
Output: (4,S,4,6,G,S,6)


Task 2: Collect Points
Submitted by: Mohammad S Anwar
You are given a list of numbers.

You will perform a series of removal operations. For each operation, you remove from the list N (one or more) equal and consecutive numbers, and add to your score N × N.

Determine the maximum possible score.

Example 1:
Input: @numbers = (2,4,3,3,3,4,5,4,2)
Output: 23

We see three 3's next to each other so let us remove that first and collect 3 x 3 points.
So now the list is (2,4,4,5,4,2).
Let us now remove 5 so that all 4's can be next to each other and collect 1 x 1 point.
So now the list is (2,4,4,4,2).
Time to remove three 4's and collect 3 x 3 points.
Now the list is (2,2).
Finally remove both 2's and collect 2 x 2 points.
So the total points collected is 9 + 1 + 9 + 4 => 23.

Example 2:
Input: @numbers = (1,2,2,2,2,1)
Output: 20

Remove four 2's first and collect 4 x 4 points.
Now the list is (1,1).
Finally remove the two 1's and collect 2 x 2 points.
So the total points collected is 16 + 4 => 20.

Example 3:
Input: @numbers = (1)
Output: 1

Example 4:
Input: @numbers = (2,2,2,1,1,2,2,2)
Output: 40

Remove two 1's = 2 x 2 points.
Now the list is (2,2,2,2,2,2).
Then reomove six 2's = 6 x 6 points.
