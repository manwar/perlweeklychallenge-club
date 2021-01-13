#!/usr/bin/env raku
# 
#
#       tiny_numbers_on_the_hillside.raku
#
#         TASK #1 › Smallest Positive Number Bits
#         Submitted by: Mohammad S Anwar
#         You are given unsorted list of integers @N.
# 
#         Write a script to find out the smallest positive number missing.
# 
#         Example 1:
#             Input: @N = (5, 2, -2, 0)
#             Output: 1
#         Example 2:
#             Input: @N = (1, 8, -1)
#             Output: 2
#         Example 3:
#             Input: @N = (2, 0, -1)
#             Output: 1
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (*@input) ;
@input.elems == 0 and @input = 5, 2, -2, 0, 16, 1, 6, 3, -18, 1, 0, 4;
my %lookup = @input.Bag;

say "input : ", @input;
%lookup{$_}:exists or say "output:  $_" and exit for (1..*);



