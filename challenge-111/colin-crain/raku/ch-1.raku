#!/usr/bin/env perl6
#
#
#       are-we-in.raku
#
#       Search Matrix
#         Submitted by: Mohammad S Anwar
#         You are given 5x5 matrix filled with integers such that each row is
#         sorted from left to right and the first integer of each row is greater
#         than the last integer of the previous row.
# 
#         Write a script to find a given integer in the matrix using an
#         efficient search algorithm.
# 
#         Example
# 
#             Matrix: [  1,  2,  3,  5,  7 ]
#                     [  9, 11, 15, 19, 20 ]
#                     [ 23, 24, 25, 29, 31 ]
#                     [ 32, 33, 39, 40, 42 ]
#                     [ 45, 47, 48, 49, 50 ]
# 
#             Input:  35
#             Output: 0     since it is missing in the matrix
# 
#             Input:  39
#             Output: 1     as it exists in the matrix
#
#       method:
#         In Raku we will output a boolean TRUE/FALSE value
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $val = 23) ;

our @mat =    [  1,  2,  3,  5,  7 ],
              [  9, 11, 15, 19, 20 ],
              [ 23, 24, 25, 29, 31 ],
              [ 32, 33, 39, 40, 42 ],
              [ 45, 47, 48, 49, 50 ]  ;
              

say @mat.first({ $val == any $_.list  })
        .Bool;
