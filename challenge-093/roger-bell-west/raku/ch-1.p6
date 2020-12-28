#! /usr/bin/perl6

use Test;

plan 2;

is(mp((1,1), (2,2), (3,3)),3,'example 1');
is(mp((1,1), (2,2), (3,1), (1,3), (5,3)),3,'example 2');

sub mp (**@c) {
  my $epsilon=0.0001;
  my $mxp=0;
  for (0..@c.end-2) -> $a {
    for ($a+1..@c.end-1) -> $b {
      my @d=map {@c[$b][$_]-@c[$a][$_]},(0,1);
      my $pil=2;
      for ($b+1..@c.end) -> $c {
        my $tp=0;
        my @v=map {@c[$c][$_]-@c[$a][$_]},(0,1);
        if (@d[0]==0) {
          if (@v[0]==0) {
            $tp=1;
          }
        } elsif (@d[1]==0) {
          if (@v[1]==0) {
            $tp=1;
          }
        } elsif (abs(@v[0]/@d[0]-@v[1]/@d[1]) < $epsilon) {
          $tp=1;
        }
        if ($tp) {
          $pil++;
        }
      }
      if ($pil > $mxp) {
        $mxp=$pil;
      }
    }
  }
  return $mxp;
}
