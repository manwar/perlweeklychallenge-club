#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-06-03
# Week: 011
# Challenge: #1
#
# Write a script that computes the equal point in the Fahrenheit and Celsius
# scales, knowing that the freezing point of water is 32 �F and 0 �C, and that
# the boiling point of water is 212 �F and 100 �C. This challenge was proposed
# by Laurent Rosenfeld.
#
# Deriving the equations C = (F - 32) / 1.8 and F = (1.8 * C ) + 32 from
# the freezing point and boiling point values.  Simply iterating over a
# value for F and C until the results match gives the point where they are
# equal.  Since they seem to be getting closer as the values decrease I started
# at the lowest value given (0) and decremented until the point where they
# matched was found.

use strict;
use warnings;
use feature qw / say /;

my $value = 0;
my $found = 0;

while ( !$found ) {
    if ( ( ( 1.8 * $value ) + 32 ) == ( ( $value - 32 ) / 1.8 ) ) {
        $found = 1;
    }
    else {
        $value--;
    }
}

say "The equal point in the Fahrenheit and Celsius scales is $value.";