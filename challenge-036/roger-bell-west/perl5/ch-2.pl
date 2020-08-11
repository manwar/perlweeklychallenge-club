#! /usr/bin/perl

use strict;
use warnings;

# Write a program to solve Knapsack Problem.
# (specifically 0-1 knapsack)

my %box=(
  R => {w => 1, v => 1},
  B => {w => 1, v => 2},
  G => {w => 2, v => 2},
  Y => {w => 12, v => 4},
  P => {w => 4, v => 10},
    );

my @k=keys %box;
my @v=map {2**$_} (0..$#k);
my $maxw=15;
my $maxb=scalar @k;

# $maxb=3;

my $bestv=0;
my $bestw=0;
my $bestid=0;

foreach my $map (1..2**(scalar @k)-1) {
  my $b=0;
  my $v=0;
  my $w=0;
  foreach my $ci (0..$#k) {
    if ($map & $v[$ci]) {
      $v+=$box{$k[$ci]}{v};
      $w+=$box{$k[$ci]}{w};
      $b++;
    }
    if ($b>$maxb || $w>$maxw) {
      $v=-1;
      last;
    }
  }
  if ($v>0) {
    if ($v>$bestv || ($v==$bestv && $w>$maxw)) {
      $bestv=$v;
      $bestw=$w;
      $bestid=$map;
    }
  }
}

foreach my $ci (0..$#k) {
  if ($bestid & $v[$ci]) {
    print $k[$ci],"\n";
  }
}
print "$bestv in $bestw\n";
