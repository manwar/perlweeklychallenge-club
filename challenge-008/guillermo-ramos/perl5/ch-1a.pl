#!/usr/bin/env perl

use strict;
use warnings;

my @mersenne_exps = (2, 3, 5, 7, 13);

foreach my $exp (@mersenne_exps) {
    print 2**($exp - 1) * (2**$exp - 1), "\n";
}
