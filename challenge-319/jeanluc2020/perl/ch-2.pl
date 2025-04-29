#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-319/#TASK2
#
# Task 2: Minimum Common
# ======================
#
# You are given two arrays of integers.
#
# Write a script to return the minimum integer common to both arrays. If none
# found return -1.
#
## Example 1
##
## Input: @array_1 = (1, 2, 3, 4)
##        @array_2 = (3, 4, 5, 6)
## Output: 3
##
## The common integer in both arrays: 3, 4
## The minimum is 3.
#
#
## Example 2
##
## Input: @array_1 = (1, 2, 3)
##        @array_2 = (2, 4)
## Output: 2
#
#
## Example 3
##
## Input: @array_1 = (1, 2, 3, 4)
##        @array_2 = (5, 6, 7, 8)
## Output: -1
#
############################################################
##
## discussion
##
############################################################
#
# We turn the elements from the first array into the keys of a hash.
# Then we walk the sorted second list. As soon as an element can be
# found in the hash, it is the searched minimum. If we didn't find
# any element, we just return the default for our result, -1.

use v5.36;

minimum_common( [1, 2, 3, 4], [3, 4, 5, 6] );
minimum_common( [1, 2, 3], [2, 4] );
minimum_common( [1, 2, 3, 4],[5, 6, 7, 8] );

sub minimum_common( $array_1, $array_2 ) {
    say "Input: (" . join(", ", @$array_1) . "),";
    say "       (" . join(", ", @$array_2) . ")";
    my $tmp;
    my $result = -1;
    foreach my $elem (@$array_1) {
        $tmp->{$elem} = 1;
    }
    foreach my $elem (sort {$a <=> $b} @$array_2) {
        if($tmp->{$elem}) {
            $result = $elem;
            last;
        }
    }
    say "Output: $result";
}
