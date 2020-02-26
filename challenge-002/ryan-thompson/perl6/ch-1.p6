#!/usr/bin/env perl6

# ch-1.p6 - Remove leading zeroes from positive numbers
#
# Ryan Thompson <rjt@cpan.org>

use v6;

S/^0+ <?[ 1..9 ]>//.say for $*ARGFILES.lines;
