#! /usr/bin/perl

use strict;
use warnings;

my @in=([1,2,3],
        [4,5,6],
        [7,8,9],
          );

my @out=rotate(1,@in);

foreach my $r (@out) {
  print '[ '.join(', ',@{$r})." ]\n";
}

sub rotate {
  my ($rotations,@in)=@_;
  my $xs=$#in;
  foreach my $ya (@in) {
    if ($#{$ya} != $xs) {
      die "not a square matrix\n";
    }
  }
  my @out=@in;
  foreach (1..$rotations) {
    my @im=@out;
    my @tmp;
    foreach my $x (0..$xs) {
      foreach my $y (0..$xs) {
        $tmp[$y][$xs-$x]=$im[$x][$y];
      }
    }
    @out=@tmp;
  }
  return @out;
}
