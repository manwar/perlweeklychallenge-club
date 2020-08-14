#!/usr/bin/env perl6
# 
#
#       open-the-window.raku
# 
#       TASK #1 › Min Sliding Window
#         Submitted by: Mohammad S Anwar
# 
#         You are given an array of integers @A and sliding window size $S.
# 
#         Write a script to create an array of min from each sliding window.
# 
#         Example
#             Input: @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8) and $S = 3
#             Output: (0, 0, 0, 2, 3, 3, 4, 4)
# 
#             [(1 5 0) 2 9 3 7 6 4 8] = Min (0)
#             [1 (5 0 2) 9 3 7 6 4 8] = Min (0)
#             [1 5 (0 2 9) 3 7 6 4 8] = Min (0)
#             [1 5 0 (2 9 3) 7 6 4 8] = Min (2)
#             [1 5 0 2 (9 3 7) 6 4 8] = Min (3)
#             [1 5 0 2 9 (3 7 6) 4 8] = Min (3)
#             [1 5 0 2 9 3 (7 6 4) 8] = Min (4)
#             [1 5 0 2 9 3 7 (6 4 8)] = Min (4)
# 
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $S where $S > 0 = 3, *@A );

## default array
@A = 1, 5, 0, 2, 9, 3, 7, 6, 4, 8 if @A.elems == 0;

## make windows and find min within each to output
my @windows = @A.rotor($S=>-$S+1);
my @output = @windows.map( *.min );

## output 
say "input:   ", @A, "    window size $S";
say "windows: ", |@windows;
say "output:  ", @output;

