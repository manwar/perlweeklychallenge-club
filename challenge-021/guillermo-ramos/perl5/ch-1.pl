#!/usr/bin/env perl
#
# Write a script to calculate the value of e, also known as Euler’s number and
# Napier’s constant. Please checkout wiki page for more information.
################################################################################

use strict;
use warnings;

my $ITERS = shift or die "Usage: $0 <iterations>";

my $e = 1;
my $denom = 1;
foreach my $i (1 .. $ITERS) {
    $denom *= $i;
    $e += 1/$denom;
}

print "$e\n";
