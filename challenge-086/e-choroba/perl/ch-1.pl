#!/usr/bin/perl
use warnings;
use strict;

sub pair_difference {
    my ($A, @N) = @_;
    my %n;
    ++$n{$_} for @N;
    return grep $_ > 1, values %n if 0 == $A;

    # See the performance of "Many duplicates" on why we iterate over
    # keys instead of @N.
    for my $x (keys %n) {
        my $B = abs($A - $x);
        return 1 if exists $n{$B} || exists $n{-$B};
    }
    return 0
}

use Test::More;

is pair_difference(7, 10, 8, 12, 15, 5), 1, 'Example 1';
is pair_difference(6, 1, 5, 2, 9, 7), 1, 'Example 2';
is pair_difference(15, 10, 30, 20, 50, 40), 0, 'Example 3';

is pair_difference(-7, 10, 8, 12, 15, 5), 1, 'Example 1 but negative';
is pair_difference(0, 1, 2, 3), 0, 'Zero';
is pair_difference(0, 1, 2, 2), 1, 'Zero with duplicate';
is pair_difference(1, (1) x 10_000_000, (3) x 10_000_000, 2), 1, 'Many duplicates';
done_testing();
