#!/usr/bin/env perl
use strict;
use warnings;

sub total_zero{
  my ($x, $y) = @_;
  my $c = 0;
  do{($x >= $y) ? ($x -= $y) : ($y -= $x); $c++}while($x>0 && $y>0);
  $c;
}

print total_zero(5,4), "\n";
print total_zero(4,6), "\n";
print total_zero(2,5), "\n";
print total_zero(3,1), "\n";
print total_zero(7,4), "\n";
