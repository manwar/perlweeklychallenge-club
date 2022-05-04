#!/usr/bin/perl
use warnings;
use strict;

sub sum_bitwise_operator {
    my $sum = 0;
    my %seen;
    for my $i (1 .. $#_) {
        for my $j (0 .. $i - 1) {
            my @pair = sort { $a <=> $b } @_[$i, $j];
            $sum += $pair[0] & $pair[1] unless $seen{"@pair"}++;
        }
    }
    return $sum
}

use Test::More tests => 3;

is sum_bitwise_operator(1, 2, 3), 3, 'Example 1';
is sum_bitwise_operator(2, 3, 4), 2, 'Example 2';

is sum_bitwise_operator(2, 2, 3, 3, 3), 7, 'Unique pairs with duplicates';
