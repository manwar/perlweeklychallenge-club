#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub split_strings($separator, @words) {
    return [grep length, map split(/\Q$separator/), @words]
}

use Test2::V0;
plan 2;

is split_strings('.', 'one.two.three','four.five','six'),
    ['one', 'two', 'three', 'four', 'five', 'six'],
    'Example 1';

is split_strings('$', '$perl$$', '$$raku$'),
    ['perl', 'raku'],
    'Example 2';
