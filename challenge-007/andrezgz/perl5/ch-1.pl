#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-007/
# Challenge #1
# Print all the niven numbers from 0 to 50 inclusive, each on their own line.
# A niven number is a non-negative number that is divisible by the sum of its digits.

use strict;
use warnings;

#0 is not a niven number because it in not divisible by 0. So I start with 1.
use List::Util qw(sum);
map { CORE::say unless ( $_ % sum(split //) ) } (1..50);
