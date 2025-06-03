#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Math::Combinatorics;

sub total_xor(@ints) {
    my $total = 0;
    for my $size (1 .. @ints) {
        my $comb = 'Math::Combinatorics'->new(count => $size, data => \@ints);
        while (my @combo = $comb->next_combination) {
            my $xor = 0;
            $xor ^= $_ for @combo;
            $total += $xor;
        }
    }
    return $total
}

use Test::More tests => 3;

is total_xor(1, 3), 6, 'Example 1';
is total_xor(5, 1, 6), 28, 'Example 2';
is total_xor(3, 4, 5, 6, 7, 8), 480, 'Example 3';
