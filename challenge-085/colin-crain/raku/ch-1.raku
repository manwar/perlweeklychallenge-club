#!/usr/bin/env perl6
#
#
#       triple_combo.raku
#
#         TASK #1 › Triplet Sum
#         Submitted by: Mohammad S Anwar
#         You are given an array of real numbers greater than zero.
#
#         Write a script to find if there exists a triplet (a,b,c) such that
#         1 < a+b+c < 2. Print 1 if you succeed otherwise 0.
#
#         Example 1:
#             Input: @R = (1.2, 0.4, 0.1, 2.5)
#             Output: 1 as 1 < 1.2 + 0.4 + 0.1 < 2
#
#         Example 2:
#             Input: @R = (0.2, 1.5, 0.9, 1.1)
#             Output: 0
#
#         Example 3:
#             Input: @R = (0.5, 1.1, 0.3, 0.7)
#             Output: 1 as 1 < 0.5 + 1.1 + 0.3 < 2

#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( *@reals ) ;

@reals.elems == 0 and @reals = (1.2, 0.4, 0.1, 2.5);


say @reals  .combinations(3)
            .map({sum $_})
            .grep({ 1 < $_ < 2 })
            .elems  ?? 1
                    !! 0 ;

