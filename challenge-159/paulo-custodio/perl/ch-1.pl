#!/usr/bin/env perl

# Challenge 159
#
# TASK #1 › Farey Sequence
# Submitted by: Mohammad S Anwar
# You are given a positive number, $n.
#
# Write a script to compute Farey Sequence of the order $n.
#
# Example 1:
# Input: $n = 5
# Output: 0/1, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1.
# Example 2:
# Input: $n = 7
# Output: 0/1, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 2/5, 3/7, 1/2, 4/7, 3/5, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 1/1.
# Example 3:
# Input: $n = 4
# Output: 0/1, 1/4, 1/3, 1/2, 2/3, 3/4, 1/1.

use Modern::Perl;
use ntheory qw( gcd );

my $n = shift || 1;
say join(", ", farey_sequence($n));

sub farey_sequence {
    my($n) = @_;
    my @seq = ([0,1], [1,1]);   # first and last terms

    for my $i (1..$n) {
        for my $j ($i+1..$n) {
            if (gcd($i, $j)==1) {
                push @seq, [$i,$j];
            }
        }
    }

    @seq = sort { $a->[0]/$a->[1] <=> $b->[0]/$b->[1] } @seq;
    @seq = map {$_->[0].'/'.$_->[1]} @seq;

    return @seq;
}
