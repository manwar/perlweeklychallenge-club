#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-08-12
# Week: 021
#
# Task #1
#
# Write a script to calculate the value of e, also known as Euler’s
# number and Napier’s constant. Please checkout wiki page for more
# information.
# https://en.wikipedia.org/wiki/E_(mathematical_constant)

use strict;
use warnings;
use feature qw/ say /;
use Math::BigFloat;

my $number     = 0;
my $factorial  = 1;
my $e          = Math::BigFloat->new( 1 / $factorial );
my $previous_e = 0;

while ( $e != $previous_e ) {
    #    say $e;
    $number++;
    $factorial *= $number;
    $previous_e = $e->copy();
    $e += ( 1 / $factorial );
}

# This is only accurate to 15 decimal places, oops.
my $dp = 15;
say "value of e to $dp decimal places: ", $e->fround($dp);
