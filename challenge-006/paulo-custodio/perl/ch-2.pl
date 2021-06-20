#!/usr/bin/perl

# Challenge 006
#
# Challenge #2
# Create a script to calculate Ramanujan's constant with at least 32 digits of 
# precision. Find out more about it here.
#
# The standard IEEE 754 double-precision binary floating-point format: binary64
# gives only 15 to 17 significant decimal digits
# Therefore must use the bignum library

use strict;
use warnings;
use 5.030;
use Math::BigFloat;

my $accuracy = 128;

my $e = Math::BigFloat->bpi($accuracy) * Math::BigFloat->bsqrt(163, $accuracy);
my $k = Math::BigFloat->bexp($e, $accuracy);
say $k->bround(30);
