#!/usr/bin/env perl6
#
#
#       max-gap.raku
#
#         TASK #1 › Maximum Gap
#         Submitted by: Mohammad S Anwar
#         You are given an array of integers @N.
# 
#         Write a script to display the maximum difference between two successive 
#         elements once the array is sorted.
# 
#         If the array contains only 1 element then display 0.
# 
#         Example
# 
#             Input: @N = (2, 9, 3, 5)
#             Output: 4
# 
#             Input: @N = (1, 3, 8, 2, 0)
#             Output: 5
# 
#             Input: @N = (5)
#             Output: 0
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use Test;

is max-gap(2,9,14,5)  ,  5, 'last';
is max-gap(2,19,13,15), 11, '1st';
is max-gap(22,19,13,15), 4, 'mid';


sub max-gap ( *@input ) {
    my $gap;
    @input.sort
          .reduce: {$gap = max( $^b-$^a, $gap); $b} ;
    return $gap;
}





