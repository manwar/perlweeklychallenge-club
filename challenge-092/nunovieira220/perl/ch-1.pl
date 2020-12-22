#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
use List::Util qw(any);

# Input
my $A = "sum";
my $B = "add";

# Isomorphic Strings
my $len = length($A);
my $res = 1;
my %map = ();

return 0 if ($len != length($B));

for my $i (0..$len - 1) {
  my $cA = substr($A, $i, 1);
  my $cB = substr($B, $i, 1);

  $map{$cA} = $cB if(!defined $map{$cA} && !(any { $_ eq $cB } values %map));
  next if (defined $map{$cA} && $map{$cA} eq $cB);

  $res = 0;
  last;
}

# Output
say ($res);