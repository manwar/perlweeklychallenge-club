Perl Weekly Challenge 210
https://theweeklychallenge.org/blog/perl-weekly-challenge-210/

Task 1: Kill and Win
Submitted by: Mohammad S Anwar
You are given a list of integers.

Write a script to get the maximum points. You are allowed to take out (kill) any integer and remove from the list. However if you do that then all integers exactly one-less or one-more would also be removed. Find out the total of integers removed.

Example 1
Input: @int = (2, 3, 1)
Output: 6

First we delete 2 and that would also delete 1 and 3. So the maximum points we get is 6.

Example 2
Input: @int = (1, 1, 2, 2, 2, 3)
Output: 11

First we delete 2 and that would also delete both the 1's and the 3. Now we have (2, 2).
Then we delete another 2 and followed by the third deletion of 2. So the maximum points we get is 11.


Task 2: Number Collision
Submitted by: Mohammad S Anwar
You are given an array of integers which can move in right direction if it is positive and left direction when negative. If two numbers collide then the smaller one will explode. And if both are same then they both explode. We take the absolute value in consideration when comparing.

All numbers move at the same speed, therefore any 2 numbers moving in the same direction will never collide.

Write a script to find out who survives the collision.

Example 1:
Input: @list = (2, 3, -1)
Output: (2, 3)

The numbers 3 and -1 collide and -1 explodes in the end. So we are left with (2, 3).

Example 2:
Input: @list = (3, 2, -4)
Output: (-4)

The numbers 2 and -4 collide and 2 explodes in the end. That gives us (3, -4).
Now the numbers 3 and -4 collide and 3 explodes. Finally we are left with -4.

Example 3:
Input: @list = (1, -1)
Output: ()

The numbers 1 and -1 both collide and explode. Nothing left in the end.
