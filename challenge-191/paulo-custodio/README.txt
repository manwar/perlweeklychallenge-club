Perl Weekly Challenge 191
https://theweeklychallenge.org/blog/perl-weekly-challenge-191/

Task 1: Twice Largest
Submitted by: Mohammad S Anwar
You are given list of integers, @list.

Write a script to find out whether the largest item in the list is at least twice as large as each of the other items.

Example 1
Input: @list = (1,2,3,4)
Output: -1

The largest in the given list is 4. However 4 is not greater than twice of every remaining elements.
1 x 2 <= 4
2 x 2 <= 4
2 x 3 >  4

Example 2
Input: @list = (1,2,0,5)
Output: 1

The largest in the given list is 5. Also 5 is greater than twice of every remaining elements.
1 x 2 <= 5
2 x 2 <= 5
0 x 2 <= 5

Example 3
Input: @list = (2,6,3,1)
Output: 1

The largest in the given list is 6. Also 6 is greater than twice of every remaining elements.
2 x 2 <= 6
3 x 2 <= 6
1 x 2 <= 6

Example 4
Input: @list = (4,5,2,3)
Output: -1

The largest in the given list is 5. Also 5 is not greater than twice of every remaining elements.
4 x 2 >  5
2 x 2 <= 5
3 x 2 >  5


Task 2: Cute List
Submitted by: Mohammad S Anwar
You are given an integer, 0 < $n <= 15.

Write a script to find the number of orderings of numbers that form a cute list.

With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of @list is cute if for every entry, indexed with a base of 1, either

1) $list[$i] is evenly divisible by $i
or
2) $i is evenly divisible by $list[$i]

Example
Input: $n = 2
Ouput: 2

Since $n = 2, the list can be made up of two integers only i.e. 1 and 2.
Therefore we can have two list i.e. (1,2) and (2,1).

@list = (1,2) is cute since $list[1] = 1 is divisible by 1 and $list[2] = 2 is divisible by 2.
