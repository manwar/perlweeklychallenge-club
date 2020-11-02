#!/usr/bin/env perl6
# 
#
#       reverse-and-repeat.raku
#
#         TASK #1 › Reverse Integer
#         Submitted by: Mohammad S Anwar
#         You are given an integer $N.
# 
#         Write a script to reverse the given integer and print the result.
#         Print 0 if the result doesn’t fit in 32-bit signed integer.
# 
#         The number 2,147,483,647 is the maximum positive value for a 32-bit
#         signed binary integer in computing.
# 
#         Example 1:
#             Input: 1234
#             Output: 4321
#         Example 2:
#             Input: -1234
#             Output: -4321
#         Example 3:
#             Input: 1231230512
#             Output: 0

#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $num where $num > 0 = 1729) ;
                                
say $num.flip +> 31 > 0 ?? 0 
                        !! $num.flip;
