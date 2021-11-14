#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(msm([[1,0,0,0,1,0],[1,1,0,0,0,1],[1,0,0,0,0,0]]),
          [[0,0,0],[0,0,0]],'example 1');
is_deeply(msm([[0,0,1,1],[0,0,0,1],[0,0,1,0]]),
          [[0,0],[0,0],[0,0]],'example 2');

use List::Util qw(min);

sub msm {
  my $m=shift;
  my $y=scalar @{$m};
  my $x=scalar @{$m->[0]};
  my $mxa=0;
  my @oc;
  foreach my $yi (0..$y-1) {
    foreach my $xi (0..$x-1) {
      if ($m->[$yi][$xi]==0) {
        my @rl;
        my $mrl=$x-$xi;
        foreach my $yj ($yi..$y-1) {
          foreach my $xj ($xi..min($xi+$mrl,$x)-1) {
            if ($m->[$yj][$xj] != 0) {
              $mrl=min($xj-$xi,$mrl);
              last;
            }
          }
          push @rl,$mrl;
        }
        foreach my $n (0..$#rl) {
          if ($rl[$n]>0) {
            my $a=$rl[$n]*($n+1);
            if ($a >= $mxa) {
              $mxa=$a;
              @oc=($rl[$n],$n+1);
            }
          }
        }
      }
    }
  }
  my @o;
  foreach my $y (1..$oc[1]) {
    push @o,[(0) x $oc[0]];
  }
  return \@o;
}
