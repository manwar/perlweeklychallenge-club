#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(buildarray([0, 2, 1, 5, 3, 4]), [0, 1, 2, 4, 5, 3], 'example 1');
is_deeply(buildarray([5, 0, 1, 2, 3, 4]), [4, 5, 0, 1, 2, 3], 'example 2');

sub buildarray($a) {
    return [map {$a->[$_]} @{$a}];
}
