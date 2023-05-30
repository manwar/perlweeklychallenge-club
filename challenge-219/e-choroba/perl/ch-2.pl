#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ min };

sub travel_expenditure($costs, $days) {
    return min(_travel_expenditure($costs, $days))
}

my @DAYS = (1, 7, 30);
sub _travel_expenditure($costs, $days) {
    my @results;
    for my $i (0, 1, 2) {
        my $period = $DAYS[$i];
        my $per_period = $costs->[$i];
        my @days_copy = @$days;
        shift @days_copy while @days_copy && $days_copy[0] <= $period;
        if (@days_copy) {
            my $subtract = $days_copy[0] - 1;
            $_ -= $subtract for @days_copy;
            my @rest = _travel_expenditure($costs, \@days_copy);
            push @results, map $_ + $per_period, @rest;
        } else {
            push @results, $per_period;
        }
    }
    return @results
}

# Speed up: 22s down to 4.
use Memoize;
memoize('_travel_expenditure',
        NORMALIZER => sub { my ($c, $d) = @_; "@$c|@$d" });

use Test::More tests => 2 + 6;

is travel_expenditure([2, 7, 25],
                      [1, 5, 6, 7, 9, 15]),
    11, 'Example 1';
is travel_expenditure([2, 7, 25],
                      [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31]),
    20, 'Example 2';

is travel_expenditure([100, 20, 1], [1, 30]), 1, 'Cheapest 30';
is travel_expenditure([100, 20, 1], [1, 31]), 2, 'Cheapest 30 twice';
is travel_expenditure([100, 1, 20], [1, 31]), 2, 'Cheapest 7';
is travel_expenditure([100, 1, 20], [1 .. 15]), 3, 'Cheapest 7';
is travel_expenditure([5, 30, 100], [1, 20 .. 49]), 105, '1+30';
is travel_expenditure([5, 6, 7], [1 .. 61]), 19, 'Large';
