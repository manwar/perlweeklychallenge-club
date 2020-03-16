#!/usr/bin/env perl

# ch-2.p6 - Colourful numbers with 3 digits
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;

sub is_colourful3 {
    my ($x, $y, $z) = split //, $_[0];
    my %seen;
    $seen{$_}++ and return 0 for $x, $y, $z, $x*$y, $y*$z, $x*$y*$z;
    return 1;
}

say for grep is_colourful3($_), 111..987;
