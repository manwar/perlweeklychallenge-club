#!/usr/bin/perl

# Challenge 096
#
# TASK #2 › Edit Distance
# Submitted by: Mohammad S Anwar
# You are given two strings $S1 and $S2.
#
# Write a script to find out the minimum operations required to convert $S1
# into $S2. The operations can be insert, remove or replace a character. Please
# check out Wikipedia page for more information.
#
# Example 1:
# Input: $S1 = "kitten"; $S2 = "sitting"
# Output: 3
#
# Operation 1: replace 'k' with 's'
# Operation 2: replace 'e' with 'i'
# Operation 3: insert 'g' at the end
# Example 2:
# Input: $S1 = "sunday"; $S2 = "monday"
# Output: 2
#
# Operation 1: replace 's' with 'm'
# Operation 2: replace 'u' with 'o'

use strict;
use warnings;
use 5.030;

# avoid repeated recursive calls of lev_dist
# for the Example 1 reduces from 29737 to 56 calls!
use Memoize;
memoize('lev_dist');

say lev_dist(@ARGV);


sub lev_dist {
    my($a, $b) = @_;

    if ($a eq '') {
        return length($b);
    }
    elsif ($b eq '') {
        return length($a);
    }
    else {
        my $ch1_diff = substr($a,0,1) ne substr($b,0,1) ? 1 : 0;
        return min(
            lev_dist(substr($a, 1), $b)+1,      # deletion
            lev_dist($a, substr($b, 1))+1,      # insertion
            lev_dist(substr($a, 1), substr($b, 1))+$ch1_diff    # substitution
        );
    }
}

sub min {
    my($min, @a) = @_;
    for (@a) {
        $min = $_ if $min > $_;
    }
    return $min;
}
