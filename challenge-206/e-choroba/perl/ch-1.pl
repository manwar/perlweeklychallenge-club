#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub shortest_time(@timestamps) {
    @timestamps = sort @timestamps;
    my $min = 24 * 60 + 59;
    for my $i (0 .. $#timestamps) {
        my ($h0, $m0) = split /:/, $timestamps[$i];
        my ($h1, $m1) = split /:/, $timestamps[ ($i + 1) % (1 + $#timestamps) ];
        my $diff = 60 * $h1 + $m1 - 60 * $h0 - $m0
                 + ($i == $#timestamps ? 24 * 60 : 0);
        $min = $diff if $diff < $min;
    }
    return $min
}

use Test::More tests => 3 + 2;

is shortest_time("00:00", "23:55", "20:00"), 5, 'Example 1';
is shortest_time("01:01", "00:50", "00:57"), 4, 'Example 2';
is shortest_time("10:10", "09:30", "09:00", "09:55"), 15, 'Example 3';

is shortest_time("00:10", "00:10", "22:50"), 0, 'Zero';
is shortest_time("01:10", "05:20", "17:40"), 250, 'More than 1 hour';
