#!/usr/bin/perl

=head1

Week 144:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-144

Task #1: Semiprime

    Write a script to generate all Semiprime number <= 100.

=cut

use strict;
use warnings;
use Test::More;
use Test::Deep;
use ntheory qw(semi_primes);

# Sample copied from https://oeis.org/A001358
my $exp = [
    4,  6,  9,  10, 14,
    15, 21, 22, 25, 26,
    33, 34, 35, 38, 39,
    46, 49, 51, 55, 57,
    58, 62, 65, 69, 74,
    77, 82, 85, 86, 87,
    91, 93, 94, 95,
];

is_deeply(semi_primes(100), $exp, 'Example');

done_testing;
