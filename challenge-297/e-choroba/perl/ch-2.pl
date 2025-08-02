#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub semi_ordered_permutation(@ints) {
    my ($pos_1, $pos_n);
    for my $i (0 .. $#ints) {
        if ($ints[$i] == 1) {
            $pos_1 = $i;
        } elsif ($ints[$i] == @ints) {
            $pos_n = $i;
        }
    }
    return $pos_1 + $#ints - $pos_n - ($pos_1 > $pos_n ? 1 : 0)
}

use Test::More tests => 3;

is semi_ordered_permutation(2, 1, 4, 3), 2, 'Example 1';
is semi_ordered_permutation(2, 4, 1, 3), 3, 'Example 2';
is semi_ordered_permutation(1, 3, 2, 4, 5), 0, 'Example 3';
