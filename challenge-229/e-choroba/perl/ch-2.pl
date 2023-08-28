#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub two_out_of_three(@arrays) {
    my %seen;
    for my $index (0 .. 2) {
        undef $seen{$_}{$index} for @{ $arrays[$index] };
    }
    return [grep 2 <= keys %{ $seen{$_} }, keys %seen]
}

use Test2::V0;
plan 2;

is two_out_of_three([1, 1, 2, 4], [2, 4], [4]),
    bag { item $_ for 2, 4 },
    'Example 1';
is two_out_of_three([4, 1], [2, 4], [1, 2]),
    bag { item $_ for 1, 2, 4 },
    'Example 2';
