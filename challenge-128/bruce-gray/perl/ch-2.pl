#!/usr/bin/env perl
# Translation of my Raku solution.
use strict;
use warnings;
use 5.026;
use experimental    qw<signatures>;
use List::Util 1.56 qw<max zip>;

sub time_to_offset ( $hh_mm_time ) {
    $hh_mm_time =~ m{ \A (\d\d?) : (\d\d) \z }msx
        or return; 
    return $1 * 60 + $2;
}
sub max_trains ( $arrivals, $departures ) {
    die if @{$arrivals} != @{$departures};

    my @times;
    for ( zip($arrivals, $departures) ) {
        my ( $start, $end ) = map { time_to_offset($_) // die } @{$_};
        $times[$_]++ for $start..$end;
    }

    return max grep {defined} @times;
}

my @tests = (
    [
        [ qw<11:20 14:30> ],
        [ qw<11:50 15:00> ],
    ],
    [
        [ qw<10:20 11:00 11:10 12:20 16:20 19:00> ],
        [ qw<10:30 13:20 12:40 12:50 20:20 21:20> ],
    ],
);
say max_trains($_->[0], $_->[1]) for @tests;
