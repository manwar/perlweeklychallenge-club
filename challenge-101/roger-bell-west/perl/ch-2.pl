#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is_deeply(ot([0,1],[1,0],[2,2]),0,'example 1');
is_deeply(ot([1,1],[-1,1],[0,-3]),1,'example 2');
is_deeply(ot([0,1],[2,0],[-6,0]),1,'example 3');

sub ot {
  my @points=@_;
  $points[3]=$points[0];
  my @xp;
  foreach my $i (0..2) {
    push @xp,($points[$i][0] *
                ($points[$i+1][1]-$points[$i][1]))
      -
      ($points[$i][1] *
       ($points[$i+1][0]-$points[$i][0]));
  }
  @xp=sort @xp;
  if ($xp[0]<=0 && $xp[2] <=0) {
    return 1;
  }
  if ($xp[0]>=0 && $xp[2] >=0) {
    return 1;
  }
  return 0;
}
