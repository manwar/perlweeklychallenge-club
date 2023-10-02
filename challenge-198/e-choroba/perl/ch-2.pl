#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use ntheory ();

sub prime_count($n) {
    ntheory::prime_count($n - 1)
}

use Test::More tests => 4 + 2;

is prime_count(10), 4, 'Example 1';
is prime_count(15), 6, 'Example 2';
is prime_count( 1), 0, 'Example 3';
is prime_count(25), 9, 'Example 4';

is prime_count(1_000_000), 78_498, 'Large';
is prime_count(11), 4, 'less than';
