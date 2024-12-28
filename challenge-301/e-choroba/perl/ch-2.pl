#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub hamming_distance(@ints) {
    my $distance = 0;
    for my $i (1 .. $#ints) {
        for my $j (0 .. $i - 1) {
            $distance += unpack '%32b*', pack 'L', $ints[$i] ^ $ints[$j];
        }
    }
    return $distance
}

use Test::More tests => 2;

is hamming_distance(4, 14, 2), 6, 'Example 1';
is hamming_distance(4, 14, 4), 4, 'Example 2';
