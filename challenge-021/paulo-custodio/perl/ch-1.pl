#!/usr/bin/perl

# Challenge 021
#
# Task #1
# Write a script to calculate the value of e, also known as Euler’s number and
# Napier’s constant. Please checkout wiki page for more information.

use strict;
use warnings;
use 5.030;

sub calc_e {
    my $e = 1;
    my($n, $prod, $prev) = (0, 1, 0);
    while ($prev != $e) {
        $prev = $e;
        $e += 1/($prod *= ++$n);
    }
    return $e;
}

say calc_e();
