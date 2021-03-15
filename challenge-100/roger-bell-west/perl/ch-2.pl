#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(ts([[1],[2,4],[6,4,9],[5,1,7,2]]),8,'example 1');
is(ts([[3],[3,1],[5,2,3],[4,3,1,3]]),7,'example 2');

use List::Util qw(min);

sub ts {
  my $in=shift;
  my @b;
  my $n=0;
  my $i=0;
  my $s=$in->[0][0];
  my @r;
  while (1) {
    if (@b) {
      my $t=pop @b;
      ($n,$i,$s)=@{$t};
    }
    if ($n < $#{$in}) {
      $n++;
      foreach my $ix ($i,$i+1) {
        push @b,[$n,$ix,$s+$in->[$n][$ix]];
      }
    } else {
      push @r,$s;
    }
    unless (@b) {
      last;
    }
  }
  return min(@r);
}
