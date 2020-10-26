#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(fs([
  [0,1,0,1],
  [0,0,1,0],
  [1,1,0,1],
  [1,0,0,1]]),
   1,'example 1');

is(fs([
  [1,1,0,1],
  [1,1,0,0],
  [0,1,1,1],
  [1,0,1,1]]),
   4,'example 2');

is(fs([
  [0,1,0,1],
  [1,0,1,0],
  [0,1,0,0],
  [1,0,0,1]]),
   0,'example 3');

use List::Util qw(min);

sub fs {
  my $s=shift;
  my $t=0;
  my $maxx=$#{$s};
  my $maxy=$#{$s->[0]};
  foreach my $x (0..$maxx-1) {
    foreach my $y (0..$maxy-1) {
      if ($s->[$x][$y]==1) {
        foreach my $d (1..min($maxx-$x,$maxy-$y)) {
          if ($s->[$x+$d][$y]==1 &&
                $s->[$x][$y+$d]==1 &&
                $s->[$x+$d][$y+$d]==1
                  ) {
            $t++;
          }
        }
      }
    }
  }
  return $t;
}
