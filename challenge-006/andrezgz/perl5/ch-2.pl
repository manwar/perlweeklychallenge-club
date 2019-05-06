#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-006/
# Challenge #2
# Create a script to calculate Ramanujan's constant with at least 32 digits of precision. Find out more about it here.
# https://en.wikipedia.org/wiki/Heegner_number#Almost_integers_and_Ramanujan's_constant

use strict;
use warnings;

use Math::BigFloat qw/bpi/;

print Math::BigFloat->new(163)->bsqrt->bmul(bpi)->bexp(32);
