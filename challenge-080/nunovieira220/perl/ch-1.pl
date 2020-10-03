#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(first);

# Input
my @A = @ARGV || (5, 2, -2, 0);

# Smallest positive number bits
my @flags = ();

for (@A) {
  $flags[$_] = 1 if($_ >= 0);
}

my $res = first { !defined($flags[$_]) } 1..$#flags;

# Output
print $res."\n";