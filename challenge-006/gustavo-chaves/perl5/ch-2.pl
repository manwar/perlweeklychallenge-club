#!/usr/bin/env perl

# Create a script to calculate Ramanujan’s constant with at least 32 digits of
# precision. Find out more about it here:
# https://en.wikipedia.org/wiki/Heegner_number#Almost_integers_and_Ramanujan's_constant

use 5.026;
use strict;
use warnings;
use bignum 'PI';

say PI()->bmul(sqrt(163))->bexp(32);
