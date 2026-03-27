Perl Weekly Challenge 213
https://theweeklychallenge.org/blog/perl-weekly-challenge-213/

Task 1: Fun Sort
Submitted by: Mohammad S Anwar
You are given a list of positive integers.

Write a script to sort the all even integers first then all odds in ascending order.

Example 1
Input: @list = (1,2,3,4,5,6)
Output: (2,4,6,1,3,5)

Example 2
Input: @list = (1,2)
Output: (2,1)

Example 3
Input: @list = (1)
Output: (1)


Task 2: Shortest Route
Submitted by: Mohammad S Anwar
You are given a list of bidirectional routes defining a network of nodes, as well as source and destination node numbers.

Write a script to find the route from source to destination that passes through fewest nodes.

Example 1:
Input: @routes = ([1,2,6], [5,6,7])
       $source = 1
       $destination = 7

Output: (1,2,6,7)

Source (1) is part of route [1,2,6] so the journey looks like 1 -> 2 -> 6
then jump to route [5,6,7] and takes the route 6 -> 7.
So the final route is (1,2,6,7)

Example 2:
Input: @routes = ([1,2,3], [4,5,6])
       $source = 2
       $destination = 5

Output: -1

Example 3:
Input: @routes = ([1,2,3], [4,5,6], [3,8,9], [7,8])
       $source = 1
       $destination = 7
Output: (1,2,3,8,7)

Source (1) is part of route [1,2,3] so the journey looks like 1 -> 2 -> 3
then jump to route [3,8,9] and takes the route 3 -> 8
then jump to route [7,8] and takes the route 8 -> 7
So the final route is (1,2,3,8,7)
