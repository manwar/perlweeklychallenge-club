#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(msm([[1,0,0,0,1,0],[1,1,0,0,0,1],[1,0,0,0,0,0]]),
          [[0,0,0],[0,0,0]],'example 1');
is-deeply(msm([[0,0,1,1],[0,0,0,1],[0,0,1,0]]),
          [[0,0],[0,0],[0,0]],'example 2');


sub msm(@m) {
  my $y=@m.elems;
  my $x=@m[0].elems;
  my $mxa=0;
  my @oc;
  for (0..$y-1) -> $yi {
    for (0..$x-1) -> $xi {
      if (@m[$yi][$xi]==0) {
        my @rl;
        my $mrl=$x-$xi;
        for ($yi..$y-1) -> $yj {
          for ($xi..min($xi+$mrl,$x)-1) -> $xj {
            if (@m[$yj][$xj] != 0) {
              $mrl=min($xj-$xi,$mrl);
              last;
            }
          }
          push @rl,$mrl;
        }
        for (0..@rl.end) -> $n {
          if (@rl[$n]>0) {
            my $a=@rl[$n]*($n+1);
            if ($a >= $mxa) {
              $mxa=$a;
              @oc=(@rl[$n],$n+1);
            }
          }
        }
      }
    }
  }
  my @o;
  for (1..@oc[1]) -> $y {
    push @o,[0 xx @oc[0]];
  }
  return @o;
}
