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

say wag_fis_dist(@ARGV);

sub wag_fis_dist {
    my($a, $b) = @_;

    # define a table where d[i,j] is the Levenshtein distance between
    # first i chars of $a and first j chars of $b
    my @d;
    $d[0][0] = 0;

    # source prefixes can be transformed into empty string by dropping chars
    $d[$_][0] = $_ for (1 .. length($a));

    # target prefixes can be reached from empty source prefix by inserting chars
    $d[0][$_] = $_ for (1 .. length($b));

    # flood-fill the rest of the table
    for my $j (1 .. length($b)) {
        for my $i (1 .. length($a)) {
            my $subst_cost =
                (substr($a,$i-1,1) eq substr($b,$j-1,1)) ? 0 : 1;
            $d[$i][$j] = min($d[$i-1][$j]+1,                # deletion
                             $d[$i][$j-1]+1,                # insertion
                             $d[$i-1][$j-1]+$subst_cost);   # substitution
        }
    }

    # distance is in lower bottom cell
    return $d[length($a)][length($b)];
}

sub min {
    my($min, @a) = @_;
    for (@a) {
        $min = $_ if $min > $_;
    }
    return $min;
}
