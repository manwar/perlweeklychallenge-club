#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-011/
# Challenge #1
# Write a script that computes the equal point in the Fahrenheit and Celsius scales,
# knowing that the freezing point of water is 32 °F and 0 °C,
# and that the boiling point of water is 212 °F and 100 °C.
# This challenge was proposed by Laurent Rosenfeld.

use strict;
use warnings;

my $f = 212;
while ( $f - ($f - 32) * (100-0)/(212-32) ) { $f-- }; #Simple, but effective
print $f;
