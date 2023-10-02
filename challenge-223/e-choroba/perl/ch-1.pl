#! /usr/bin/perl
use warnings;
use strict;

# See 198/2: we had less than, here we have less than or equal to.

use ntheory ();
*count_primes = *ntheory::prime_count{CODE};

use Test::More tests => 4 + 2;

is count_primes(10), 4, 'Example 1';
is count_primes(15), 6, 'Example 2';
is count_primes(1), 0, 'Example 3';
is count_primes(25), 9, 'Example 4';

is count_primes(1_000_000), 78_498, 'Large';
is count_primes(11), 5, 'less or equal';
