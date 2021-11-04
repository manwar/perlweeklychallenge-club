#!/usr/bin/perl
use warnings;
use strict;

sub lychrel_number {
    my ($n) = @_;
    for (1 .. 500) {

        $n += reverse $n;
        return 0 if $n == reverse $n;

        # Comment out to get the correct answer for 89.
        # "use bigint;" to make it work for 196.
        return 1 if $n >= 1e7;
    }
    return 1
}

use Test2::V0;
plan 5;

is lychrel_number(56), 0, 'Example 1';
is lychrel_number(57), 0, 'Example 2';
is lychrel_number(59), 0, 'Example 3';

# Wrong answer as 17735476 >= 1e7.
is lychrel_number(89), 1, '24 iterations';

is lychrel_number(196), 1, 'Lychrel number';
