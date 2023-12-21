#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub shortest_distance($str, $char) {
    my @distances;
    for my $pos (0 .. length($str) - 1) {
        my $l = index($str, $char, $pos) - $pos;
        if (0 <= ( my $r = rindex $str, $char, $pos )) {
            $r = $pos - $r;
            $l = $r if $r < $l;
        }
        push @distances, $l;
    }
    return \@distances
}

use Test2::V0;
plan 2;

is shortest_distance('loveleetcode', 'e'),
    [3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0],
    'Example 1';

is shortest_distance('aaab', 'b'), [3, 2, 1, 0], 'Example 2';
