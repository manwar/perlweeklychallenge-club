#!/usr/bin/perl

#
# Perl Weekly Challenge - 080
#
# Task #2: Count Candies
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-080
#

use strict;
use warnings;
use Test::More;
use List::Util qw(max);

is( count_candies([1, 2]), 3, "testing [1, 2]");
is( count_candies([1, 2, 2]), 4, "testing [1, 2, 2]");
is( count_candies([1, 5, 2, 1]), 7, "testing [1, 5, 2, 1]");

done_testing;

#
#
# METHOD

sub count_candies {
    my ($rankings) = @_;

    my $l2r = [];
    my $r2l = [];

    push @$l2r, 1 for @$rankings;
    push @$r2l, 1 for @$rankings;

    my $i = 1;
    while ($i <= $#$rankings) {
        $l2r->[$i] = $l2r->[$i - 1] + 1
               if ($rankings->[$i] > $rankings->[$i - 1]);
        $i++
    }

    my $j = $#$rankings - 1;
    while ($j >= 0) {
        $r2l->[$j] = $r2l->[$j + 1] + 1
            if ($rankings->[$j] > $rankings->[$j + 1]);
        $j--;
    }

    my $count = 0;
    $count += max($l2r->[$_], $r2l->[$_]) for (0 .. $#$rankings);

    return $count;
}
