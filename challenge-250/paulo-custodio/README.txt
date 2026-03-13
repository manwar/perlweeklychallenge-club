Challenge 250
https://theweeklychallenge.org/blog/perl-weekly-challenge-250/

Task 1: Smallest Index
Submitted by: Mohammad S Anwar
You are given an array of integers, @ints.

Write a script to find the smallest index i such that i mod 10 == $ints[i] otherwise return -1.

Example 1
Input: @ints = (0, 1, 2)
Output: 0

i=0: 0 mod 10 = 0 == $ints[0].
i=1: 1 mod 10 = 1 == $ints[1].
i=2: 2 mod 10 = 2 == $ints[2].
All indices have i mod 10 == $ints[i], so we return the smallest index 0.

Example 2
Input: @ints = (4, 3, 2, 1)
Output: 2

i=0: 0 mod 10 = 0 != $ints[0].
i=1: 1 mod 10 = 1 != $ints[1].
i=2: 2 mod 10 = 2 == $ints[2].
i=3: 3 mod 10 = 3 != $ints[3].
2 is the only index which has i mod 10 == $ints[i].

Example 3
Input: @ints = (1, 2, 3, 4, 5, 6, 7, 8, 9, 0)
Output: -1
Explanation: No index satisfies i mod 10 == $ints[i].


Task 2: Alphanumeric String Value
Submitted by: Mohammad S Anwar
You are given an array of alphanumeric strings.

Write a script to return the maximum value of alphanumeric string in the given array.

The value of alphanumeric string can be defined as

a) The numeric representation of the string in base 10 if it is made up of digits only.
b) otherwise the length of the string


Example 1
Input: @alphanumstr = ("perl", "2", "000", "python", "r4ku")
Output: 6

"perl" consists of letters only so the value is 4.
"2" is digits only so the value is 2.
"000" is digits only so the value is 0.
"python" consits of letters so the value is 6.
"r4ku" consists of letters and digits so the value is 4.

Example 2
Input: @alphanumstr = ("001", "1", "000", "0001")
Output: 1
