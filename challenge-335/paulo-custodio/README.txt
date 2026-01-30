Challenge 335
https://theweeklychallenge.org/blog/perl-weekly-challenge-335/

Task 1: Common Characters
Submitted by: Mohammad Sajid Anwar
You are given an array of words.

Write a script to return all characters that is in every word in the given array including duplicates.


Example 1
Input: @words = ("bella", "label", "roller")
Output: ("e", "l", "l")

Example 2
Input: @words = ("cool", "lock", "cook")
Output: ("c", "o")

Example 3
Input: @words = ("hello", "world", "pole")
Output: ("l", "o")

Example 4
Input: @words = ("abc", "def", "ghi")
Output: ()

Example 5
Input: @words = ("aab", "aac", "aaa")
Output: ("a", "a")

Task 2: Find Winner
Submitted by: Mohammad Sajid Anwar
You are given an array of all moves by the two players.

Write a script to find the winner of the TicTacToe game if found based on the moves provided in the given array.

UPDATE: Order move is in the order - A, B, A, B, A, ….


Example 1
Input: @moves = ([0,0],[2,0],[1,1],[2,1],[2,2])
Output: A

Game Board:
[ A _ _ ]
[ _ A _ ]
[ B B A ]

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
