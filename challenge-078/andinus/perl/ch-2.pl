#!/usr/bin/perl

use strict;
use warnings;

my @A = qw(10 20 30 40 50);
my @B = qw(3 4);

foreach (@B) {
    my @tmp = @A;
    foreach (1 ... scalar @tmp - $_) {
        unshift @tmp, pop @tmp;
    }
    print join(', ', @tmp), "\n";
}
