#!/usr/bin/env perl

# TASK #2 > Split Number
# Submitted by: Mohammad S Anwar
# You are given a perfect square.
#
# Write a script to figure out if the square root the given number is same as
# sum of 2 or more splits of the given number.
#
# Example 1
# Input: $n = 81
# Output: 1
#
# Since, sqrt(81) = 8 + 1
# Example 2
# Input: $n = 9801
# Output: 1
#
# Since, sqrt(9801) = 98 + 0 + 1
# Example 3
# Input: $n = 36
# Output: 0
#
# Since, sqrt(36) != 3 + 6

use Modern::Perl;
use List::Util 'sum';

my $n = shift||1;
say sqroot_is_sum_splits($n);

sub get_splits {
    my($n) = @_;
    my @splits;
    add_splits(\@splits, [], $n);
    return @splits;
}

sub add_splits {
    my($splits, $path, $rest) = @_;
    if ($rest eq '') {
        push @$splits, [@$path];
    }
    else {
        for my $i (1..length($rest)) {
            my $a = substr($rest, 0, $i);
            my $b = substr($rest, $i);
            add_splits($splits, [@$path, $a], $b);
        }
    }
}

sub sqroot_is_sum_splits {
    my($n) = @_;
    my $sq = sqrt($n);
    return 0 if int($sq) != $sq;        # not pefect square
    for (get_splits($n)) {
        my @split = @$_;
        return 1 if sum(@split) == $sq;
    }
    return 0;
}
