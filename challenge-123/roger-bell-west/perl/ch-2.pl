#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

use List::MoreUtils qw(minmax);
use Math::Trig qw(rad2deg);

is(sp([
  [10,20],
  [20,20],
  [20,10],
  [10,10],
    ]),1,'example 1');

is(sp([
  [12,24],
  [16,10],
  [20,12],
  [18,16],
    ]),0,'example 2');

is(sp([
  [10,10],
  [20,0],
  [30,10],
  [20,20],
    ]),1,'example 3');

is(sp([
  [0,0],
  [3,4],
  [8,4],
  [5,0],
    ]),0,'example 4');

sub sp {
  my $m=shift;
  foreach my $ordering ([0,1,2,3,0],[0,1,3,2,0],[0,2,1,3,0]) {
    my @w=map {$m->[$ordering->[$_%4]]} (0..4);
    # check for equal sides
    my @ds;
    foreach my $pp (0..3) {
      push @ds,($w[$pp+1][0]-$w[$pp][0])**2+($w[$pp+1][1]-$w[$pp][1])**2;
    }
    my @t=minmax(@ds);
    if ($t[0] != $t[1]) {
      next;
    }
    # check for equal right angles
    my @angles;
    foreach my $pp (0..3) {
      my @delta=map {$w[$pp+1][$_]-$w[$pp][$_]} (0,1);
      my $angle;
      if ($delta[0]==0) {
        if ($delta[1]==0) {     # coincident points
          return 0;
        }
        $angle=$delta[1]>0?90:-90;
      } else {
        $angle=rad2deg(atan2($delta[1],$delta[0]));
      }
      push @angles,$angle;
    }
    push @angles,$angles[0];
    my $good=1;
    my @deltas=map {($angles[$_+1]-$angles[$_]+360)%360} (0..3);
    if ($deltas[0]!=90 && $deltas[0] != 270) {
      next;
    } else {
      foreach my $di (1..3) {
        if ($deltas[$di] != $deltas[0]) {
          $good=0;
          last;
        }
      }
    }
    return $good;
  }
  return 0;
}
