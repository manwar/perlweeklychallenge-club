#!/usr/bin/perl

#
# Perl Weekly Challenge - 079
#
# Task #2: Trapped Rain Water
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079
#

use strict;
use warnings;
use Test::More;
use List::Util qw(min);

is( trapped_rain_water([0, 1, 2, 3, 4, 5]),
    0, "testing [0, 1, 2, 3, 4, 5]");

is( trapped_rain_water([2, 1, 4, 1, 2, 5]),
    6, "testing [2, 1, 4, 1, 2, 5]");

is( trapped_rain_water([3, 1, 3, 1, 1, 5]),
    6, "testing [3, 1, 3, 1, 1, 5]");

is( trapped_rain_water([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]),
    6, "testing [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]");

done_testing;

#
#
# SUBROUTINES

sub trapped_rain_water {
    my ($arrayref) = @_;

    my @a   = ();
    my $p   = 0;
    my $trw = 0;
    foreach my $n (@$arrayref) {
        if ($p == 0 || $p >= $n) {
            $p = $n if (@a == 0 || ($p == 0 && $n > $p));
            push @a, $n;
        }
        else {
            push @a, $n;
            $trw += fetch_trapped_water(@a);
            @a = ($n);
            $p = $n if ($p < $n);
        }
    }

    # are there any left over to be processed?
    if (@a > 1) {
        $trw += fetch_trapped_water(@a);
    }

    return $trw;
}

sub fetch_trapped_water {
    my (@array) = @_;

    # remove any smaller tower from the start
    do {
        if ($array[0] == 0) {
            shift @array;
        }
    } until ($array[0] > 0);

    # remove any smaller tower from the end
    do {
        if ($array[-1] < $array[-2]) {
            pop @array;
        }
    }
    until ($array[-1] > $array[-2]);

    my $max = min($array[0], $array[-1]) * (@array - 2);
    $max -= $array[$_] for 1..@array-2;

    return $max;
}
