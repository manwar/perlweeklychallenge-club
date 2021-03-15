#!/usr/bin/env perl6
#
#
#       know-your-place.raku
#
#         TASK #2 › Search Insert Position
#         Submitted by: Mohammad S Anwar
#         You are given a sorted array of distinct integers @N and a target $N.
# 
#         Write a script to return the index of the given target if found
#         otherwise place the target in the sorted array and return the index.
# 
#         Example 1:
#             Input: @N = (1, 2, 3, 4) and $N = 3
#             Output: 2 since the target 3 is in the array at the index 2.
# 
#         Example 2:
#             Input: @N = (1, 3, 5, 7) and $N = 6
#             Output: 3 since the target 6 is missing and should be placed at the index 3.
# 
#         Example 3:
#             Input: @N = (12, 14, 16, 18) and $N = 10
#             Output: 0 since the target 10 is missing and should be placed at the index 0.
# 
#         Example 4:
#             Input: @N = (11, 13, 15, 17) and $N = 19
#             Output: 4 since the target 19 is missing and should be placed at the index 4.
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;


use Test;
plan 17;

is insert( 3,  (1, 2, 3, 4)     ), 2, 'ex-1';
is insert( 6,  (1, 3, 5, 7)     ), 3, 'ex-2';
is insert( 10, (12, 14, 16, 18) ), 0, 'ex-3';
is insert( 19, (11, 13, 15, 17) ), 4, 'ex-4';
for 1..13 -> $n is copy {
    $n = 500 - 37*$n;
    is insert( $n, (1..500) ), $n-1, "long list: target -> $n";
}




sub insert ($num, @arr) {
    $num > @arr[*-1] and return @arr.elems;
    $num < @arr[0]   and return 0;

    my $lower = 0;
    my $upper = @arr.end;

    while ( $lower <= $upper ) {
        my $pos = (($lower+$upper)/2).floor;
        return $pos if @arr[$pos] == $num or @arr[$pos-1] < $num < @arr[$pos];

        @arr[$pos] > $num ?? ($upper = $pos-1)
                          !! ($lower = $pos+1); 
    }
    
}

