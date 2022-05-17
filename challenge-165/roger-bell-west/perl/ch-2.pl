#! /usr/bin/perl

use strict;
use warnings;

use experimental 'signatures';

use List::Util qw(min max);

my @points;

while (<>) {
  chomp;
  foreach my $pp (split ' ',$_) {
    if ($pp =~ /\S/) {
      print "$pp\n";
      push @points,[split ',',$pp];
    }
  }
}

my @slope;
foreach my $i (0..$#points-1) {
  foreach my $j ($i+1..$#points) {
    if ($points[$i][0] != $points[$j][0]) {
      push @slope,($points[$j][1]-$points[$i][1])/($points[$j][0]-$points[$i][0])
    }
  }
}

my $m = median(\@slope);

my $c = median([map {$_->[1] - $m*$_->[0]} @points]);

my @x=map {$_->[0]} @points;
my @l;
foreach my $xb (min(@x),max(@x)) {
  push @l,$xb;
  push @l,$xb*$m+$c;
}

print join(',',@l),"\n";

sub median($s0) {
  my @s=sort {$a <=> $b} @{$s0};
  return $s[int((scalar @s)/2)];
}
