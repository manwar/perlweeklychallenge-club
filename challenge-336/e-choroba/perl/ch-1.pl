#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );
use Math::Prime::Util qw{ gcd };

sub equal_group(@ints) {
    my %seen;
    ++$seen{$_} for @ints;

    my $gcd = gcd(values %seen);
    return 1 == $gcd ? 0 : 1
}

use Test2::V0;
use constant { true  => bool(1),
               false => bool(0) };
plan(5);

is equal_group(1, 1, 2, 2, 2, 2), true, 'Example 1';
is equal_group(1, 1, 1, 2, 2, 2, 3, 3), false, 'Example 2';
is equal_group(5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7), true, 'Example 3';
is equal_group(1, 2, 3, 4), false, 'Example 4';
is equal_group(8, 8, 9, 9, 10, 10, 11, 11), true, 'Example 5';
