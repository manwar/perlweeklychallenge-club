#!/bin/env perl

use Modern::Perl;
use Data::Dumper;

my $n = shift;
my @a;

for my $i (0 .. $n - 1) { 
    my @b = (0) x $n;
    $b[$i] = 1;

    push(@a, \@b);
}

print Dumper(\@a);
