#!/usr/bin/perl

#
# Perl Weekly Challenge - 075
#
# Task #1: Coins Sum
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-075
#

use strict;
use warnings;
use Test::More;

is coins_sum(prepare("1, 2"),        5), 3;
is coins_sum(prepare("1, 2, 3"),     5), 5;
is coins_sum(prepare("1, 2, 4"),     6), 6;
is coins_sum(prepare("25, 10, 5"),  30), 5;
is coins_sum(prepare("9, 6, 5, 1"), 11), 6;

done_testing;

#
#
# METHODS

sub coins_sum {
    my ($coins, $sum) = @_;

    my $size = $#$coins;
    return 0 if ($size == -1 || $sum <= 0);

    my $matrix;

    # Sum of 0 can be achieved in one possible way.
    $matrix->[$_][0] = 1 for (0 .. $size+1);

    foreach my $i (0 .. $size) {

        foreach my $j (1 .. $sum) {

            my $include_current = 0;
            my $exclude_current = 0;

            if ($coins->[$i] <= $j) {
                $include_current = $matrix->[$i][$j - $coins->[$i]];
            }

            if ($i > 0) {
                $exclude_current = $matrix->[$i - 1][$j];
            }

            $matrix->[$i][$j] = $include_current + $exclude_current;
        }
    }

    return $matrix->[$size][$sum];
}

sub prepare {
    my ($coins) = @_;

    if (defined $coins) {
        $coins =~ s/\s//g;
        return [ split /\,/, $coins ];
    }
}
