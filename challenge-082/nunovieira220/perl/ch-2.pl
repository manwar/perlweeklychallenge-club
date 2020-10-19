#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my $A = "XXY";
my $B = "XXZ";
my $C = "XXXXZY";

# Output
say interleave($A, $B, $C);

# Interleave
sub interleave {
  my ($A, $B, $C) = @_;

  return 0 if(length($A) + length($B) != length($C));
  return interleaveChecker($A, $B, $C);
}

# Interleave checker
sub interleaveChecker {
  my ($A, $B, $C) = @_;

  return 1 if (!$C);

  my $a = substr($A, 0, 1);
  my $b = substr($B, 0, 1);
  my $c = substr($C, 0, 1);
  my $firstTree = 0;
  my $secondTree = 0;

  $firstTree = interleaveChecker(substr($A, 1, 1), $B, substr($C, 1, 1)) if($a eq $c);
  $secondTree = interleaveChecker($A, substr($B, 1, 1), substr($C, 1, 1)) if($b eq $c);

  return $firstTree + $secondTree > 0 || 0;
}