#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub reverse_pairs(@nums) {
    my $tally = 0;
    for my $j (1 .. $#nums) {
        for my $i (0 .. $j - 1) {
            ++$tally if $nums[$i] > 2 * $nums[$j];
        }
    }
    return $tally
}

use Test::More tests => 2;

is reverse_pairs(1, 3, 2, 3, 1), 2, 'Example 1';
is reverse_pairs(2, 4, 3, 5, 1), 3, 'Example 2';
