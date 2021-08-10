#! /usr/bin/perl

use strict;

use List::Util qw(min);

use Test::More tests => 3;

is_deeply(pt(5),[[3,4,5],[5,12,13]],'example 1');
is_deeply(pt(13),[[5,12,13],[13,84,85]],'example 2');
is_deeply(pt(1),[],'example 3');

sub pt {
  my $n=shift;
  my @out;
  my @tri=([3,4,5]);
  while (@tri) {
    my $t=shift @tri;
    foreach my $i (0..2) {
      if ($n % $t->[$i] == 0) {
        my $k=$n/$t->[$i];
        push @out,[map {$_*$k} @{$t}];
      }
    }
    unless (min(@{$t}) > $n) {
      push @tri,[
        $t->[0]-2*$t->[1]+2*$t->[2],
        2*$t->[0]-1*$t->[1]+2*$t->[2],
        2*$t->[0]-2*$t->[1]+3*$t->[2],
          ];
      push @tri,[
        $t->[0]+2*$t->[1]+2*$t->[2],
        2*$t->[0]+1*$t->[1]+2*$t->[2],
        2*$t->[0]+2*$t->[1]+3*$t->[2],
          ];
      push @tri,[
        -$t->[0]+2*$t->[1]+2*$t->[2],
        -2*$t->[0]+1*$t->[1]+2*$t->[2],
        -2*$t->[0]+2*$t->[1]+3*$t->[2],
          ];
    }
  }
  return \@out;
}
