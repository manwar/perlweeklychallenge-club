#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub binary_prefix(@num) {
    my @divisible_by_5;
    my $prefix = "";
    for my $digit (@num) {
        $prefix .= $digit;
        push @divisible_by_5, 0 == oct("b$prefix") % 5;
    }
    return @divisible_by_5
}

use Test2::V0;
plan(5);

use constant {
    true  => !! 1,
    false => !! 0};

is [binary_prefix(0, 1, 1, 0, 0, 1, 0, 1, 1, 1)],
    [map bool($_),
         true, false, false, false, false, true, true, false, false, false],
    'Example 1';

is [binary_prefix(1, 0, 1, 0, 1, 0)],
    [map bool($_), false, false, true, true, false, false],
    'Example 2';

is [binary_prefix(0, 0, 1, 0, 1)],
    [map bool($_), true, true, false, false, true],
    'Example 3';

is [binary_prefix(1, 1, 1, 1, 1)],
     [map bool($_), false, false, false, true, false],
    'Example 4';

is [binary_prefix(1, 0, 1, 1, 0, 1, 0, 0, 1, 1)],
    [map bool($_),
         false, false, true, false, false, true, true, true, false, false],
    'Example 5';
