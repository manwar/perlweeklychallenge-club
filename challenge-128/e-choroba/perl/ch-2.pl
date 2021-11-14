#!/usr/bin/perl
use warnings;
use strict;

use enum qw( ARRIVAL DEPARTURE );

sub minimum_platforms {
    my ($arr, $dep) = @_;
    die 'Different number of arrivals and departures'
        unless @$arr == @$dep;

    my @times = sort { $a->[0] <=> $b->[0] } (map [s/://r, ARRIVAL],   @$arr),
                                             (map [s/://r, DEPARTURE], @$dep);
    my ($current, $max) = (0, 0);

    # To handle trains staying over midnight, simulate two consecutive days.
    push @times, @times;

    while (@times) {
        my $time = shift @times;

        # On the first day, ignore the departing trains that arrived
        # on the previous day.
        next if DEPARTURE eq $time->[1]  && 0 == $current;

        +{(ARRIVAL)   => sub { ++$current },
          (DEPARTURE) => sub { --$current }}->{ $time->[1] }();

        $max = $current if $current > $max;
    }
    return $max
}

use Test2::V0;
plan 7;

is minimum_platforms([qw[ 11:20 14:30 ]], [qw[ 11:50 15:00 ]]), 1, 'Example 1';
is minimum_platforms([qw[ 10:20 11:00 11:10 12:20 16:20 19:00 ]],
                     [qw[ 10:30 13:20 12:40 12:50 20:20 21:20 ]]),
    3, 'Example 2';

is minimum_platforms([], []), 0, 'No trains, no platforms';
is minimum_platforms([qw[ 23:00 ]], [qw[ 1:00 ]]), 1, 'one overnight';
is minimum_platforms([qw[ 23:00 23:15 ]], [qw[ 1:00 0:40 ]]),
    2, 'two overnight';
is minimum_platforms([qw[ 23:00 23:15 23:30 ]], [qw[ 1:00 0:40 23:50 ]]),
    3, 'two overnight + 1';
is minimum_platforms([qw[ 10:01 10:02 13:01 13:02 13:03 ]],
                     [qw[ 11:01 11:02 12:01 12:02 12:03 ]]),
    5, 'three overnight + 2';
