#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub find_k_beauty($num, $k) {
    my $tally = 0;
    for my $pos (0 .. length($num) - $k) {
        ++$tally if 0 == $num % substr $num, $pos, $k;
    }
    return $tally
}

use Test::More tests => 5;

is find_k_beauty(240, 2), 2, 'Example 1';
is find_k_beauty(1020, 2), 3, 'Example 2';
is find_k_beauty(444, 2), 0, 'Example 3';
is find_k_beauty(17, 2), 1, 'Example 4';
is find_k_beauty(123, 1), 2, 'Example 5';
