#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-391/#TASK2
#
# Task 2: Arrange Box
# ===================
#
# You are given an array of box dimensions.
#
# Write a script to determine the maximum number of these boxes that can fit
# inside each other in a single stack. For a box to fit inside another, it must
# be smaller in both dimensions.
#
## Example 1
##
## Input: @boxes = ([1, 3], [3, 5], [6, 8], [2, 4])
## Output: 4
##
## Sort by width ascending: ([1, 3], [2, 4], [3, 5], [6, 8])
## Extract heights: [3, 4, 5, 8]
## [1, 3] -> [2, 4] -> [3, 5] -> [6, 8]
#
## Example 2
##
## Input: @boxes = ([4, 5], [4, 6], [6, 7], [2, 3], [4, 3])
## Output: 3
##
## Sort by width ascending: ([2, 3], [4, 6], [4, 5], [4, 3], [6, 7])
## Extract heights: (3, 6, 5, 3, 7)
## [2, 3] -> [4, 5] -> [6, 7]
#
## Example 3
##
## Input: @boxes = ([5, 5], [5, 5], [5, 5])
## Output: 1
##
## Sort by width ascending: ([5, 5], [5, 5], [5, 5])
## Extract heights: (5, 5, 5)
## [5, 5]
#
## Example 4
##
## Input: @boxes = ([2, 100], [3, 200], [4, 300], [5, 50], [5, 400])
## Output: 4
##
## Sort by width ascending: ([2, 100], [3, 200], [4, 300], [5, 400], [5, 50])
## Extract heights: (100, 200, 300, 400, 50)
## [2, 100] -> [3, 200] -> [4, 300] -> [5, 400]
#
## Example 5
##
## Input: @boxes = ([10, 20], [15, 10], [20, 30], [12, 18], [16, 25])
## Output: 3
##
## Sort by width ascending: ([10, 20], [12, 18], [15, 10], [16, 25], [20, 30])
## Extract heights: (20, 18, 10, 25, 30)
## [15, 10] -> [16, 25] -> [20, 30]
#
############################################################
##
## discussion
##
############################################################
#
# After sorting, we check for the longest chain:
# 1. Given a current element and a rest array, we recursively find the length
#    of the next possible combination (1 + length of recursive call of the rest)
# 2. When we call the function with an empty rest, we return 0 (which should
#    actually be 1, as we didn't count the current head yet)
# 3. Since we counted 1 less than we need, we add it in the end

use v5.36;

sub arrange_box(@boxes) {
    say "Input: (" . join(", ", map { "[$_->[0], $_->[1]]" } @boxes) . ")";
    my @sorted = sort { $a->[0] <=> $b->[0] or $b->[1] <=> $a->[1] } @boxes;
    say "Output: " . ( 1 + find_longest(undef, @sorted) );
}

sub find_longest($current, @rest) {
    my $longest = 0;
    foreach my $i (0..$#rest) {
        if(defined($current)) {
            if($current->[0] < $rest[$i]->[0] and $current->[1] < $rest[$i]->[1] ) {
                my $current = 1 + find_longest($rest[$i], @rest[$i+1..$#rest]);
                $longest = $current if $current > $longest;
            }
        } else {
            my $current = find_longest($rest[$i], @rest[$i+1..$#rest]);
            $longest = $current if $current > $longest;
        }
    }
    return $longest;
}

arrange_box([1, 3], [3, 5], [6, 8], [2, 4]);
arrange_box([4, 5], [4, 6], [6, 7], [2, 3], [4, 3]);
arrange_box([5, 5], [5, 5], [5, 5]);
arrange_box([2, 100], [3, 200], [4, 300], [5, 50], [5, 400]);
arrange_box([10, 20], [15, 10], [20, 30], [12, 18], [16, 25]);
