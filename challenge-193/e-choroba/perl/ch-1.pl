#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub binary_string($n) {
    return [] if 0 == $n;

    my $i = 0;
    my @strings;
    push @strings, sprintf "%0${n}b", $i++
        while $i < 2 ** $n;
    return \@strings
}

use Test2::V0;
plan 4;

is binary_string(2),
    bag { item $_ for qw[ 00 11 01 10 ]; end }, 'Example 1';
is binary_string(3),
    bag { item $_ for qw[ 000 001 010 100 111 110 101 011 ]; end }, 'Example 2';

is binary_string(1), [0, 1], 'Size 1';

my $large = binary_string(20);
is scalar @$large, 1 << 20, 'Large';
