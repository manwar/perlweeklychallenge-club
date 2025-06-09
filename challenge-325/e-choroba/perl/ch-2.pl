#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub final_price(@prices) {
    for my $i (0 .. $#prices - 1) {
        for my $j ($i + 1 .. $#prices) {
            if ($prices[$j] <= $prices[$i]) {
                $prices[$i] -= $prices[$j];
                last
            }
        }
    }
    return \@prices
}

use Test2::V0;
plan(3);

is final_price(8, 4, 6, 2, 3), [4, 2, 4, 2, 3], 'Example 1';
is final_price(1, 2, 3, 4, 5), [1, 2, 3, 4, 5], 'Example 2';
is final_price(7, 1, 1, 5), [6, 0, 1, 5], 'Example 3';
