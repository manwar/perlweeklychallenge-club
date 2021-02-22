#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is_deeply(pas([1..4]),[[1,2],[4,3]],'example 1');
is_deeply(pas([1..6]),[[1,2,3],[6,5,4]],'example 2');
is_deeply(pas([1..12]),[[1,2,3,4],[10,11,12,5],[9,8,7,6]],'example 3');

sub pas {
  my $a=shift;
  my @a=reverse @{$a};
  my $n=scalar @a;
  my $f2=int(sqrt($n));
  my $f1;
  while (1) {
    if ($n % $f2 == 0) {
      $f1=$n/$f2;
      last;
    }
    $f2--;
  }
  my @out;
  foreach (1..$f2) {
    push @out,[(0) x $f1];
  }
  my ($x,$y)=(-1,0);
  my $maxx=$f1-1;
  my $maxy=$f2-1;
  my $minx=0;
  my $miny=1;
 ARR:
  while (1) {
    while ($x < $maxx) {
      $x++;
      $out[$y][$x]=pop @a;
      unless (@a) {
        last ARR;
      }
    }
    $maxx-=1;
    while ($y < $maxy) {
      $y++;
      $out[$y][$x]=pop @a;
      unless (@a) {
        last ARR;
      }
    }
    $maxy-=1;
    while ($x > $minx) {
      $x--;
      $out[$y][$x]=pop @a;
      unless (@a) {
        last ARR;
      }
    }
    $minx++;
    while ($y > $miny) {
      $y--;
      $out[$y][$x]=pop @a;
      unless (@a) {
        last ARR;
      }
    }
    $miny++;
  }
  return \@out;
}
