#!/usr/bin/env perl
#
# ch-2.pl - Palindrome Dates (mm/dd/yyyy)
#
# Ryan Thompson <rjt@cpan.org>

use warnings;
use strict;

# All of the 2-digit years must also be months
my @yy = sort map { chop . ($_||0) } 1..12;

# Ensure printing in the correct order, with minimal looping
for my $dd (qw<02 12 22>) {
    for my $yy (@yy) {
        printf "%02d-%02d-%02d%02d\n",
            scalar reverse($yy), $dd, scalar reverse($dd), $yy;
    }
}
