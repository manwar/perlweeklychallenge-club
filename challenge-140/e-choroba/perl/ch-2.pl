#!/usr/bin/perl
use warnings;
use strict;

sub multiplication_table {
    my ($i, $j, $k) = @_;
    my @t;
    for my $l (1 .. $i) {
        push @t, map $l * $_, 1 .. $j;
    }
    return (sort { $a <=> $b } @t)[$k - 1]
}

use Test::More tests => 4;

is multiplication_table(2, 3, 4), 3, 'Example 1';
is multiplication_table(3, 3, 6), 4, 'Example 2';

is multiplication_table(10, 12, 44), 18, 'Large table';
is multiplication_table(10, 12, 45), 20, 'Large table';
