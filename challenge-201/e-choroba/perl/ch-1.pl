#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub missing_numbers($arr) {
    my %missing;
    @missing{0 .. @$arr} = ();
    delete @missing{@$arr};
    return [keys %missing]
}

use Test2::V0;
plan 2 + 2;

is missing_numbers([0, 1, 3]), [2], 'Example 1';
is missing_numbers([0, 1]), [2], 'Example 2';

is missing_numbers([]), [0], 'Empty input';
is missing_numbers([10, 11, 12]),
    bag { item $_ for 0 .. 3 },
    'Missing more than one';
