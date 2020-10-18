#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw[min];

# Input
my $M = 12;
my $N = 18;

# Get common factors
my @res = ();
for (1..min($M, $N)) {
  push @res, $_ if($M % $_ == 0 && $N % $_ == 0);
}

# Output
print join(', ', @res);