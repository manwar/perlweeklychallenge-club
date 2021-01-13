#! /usr/bin/perl6

use Test;

plan 3;

is-deeply(lr((
  (0,0,0,1,0,0),
  (1,1,1,0,0,0),
  (0,0,1,0,0,1),
  (1,1,1,1,1,0),
  (1,1,1,1,1,0),
    )),
          [
            (1,1,1,1,1),
            (1,1,1,1,1),
              ],
          'example 1');

is-deeply(lr((
  (1,0,1,0,1,0),
  (0,1,0,1,0,1),
  (1,0,1,0,1,0),
  (0,1,0,1,0,1),
    )),
          0,
          'example 2');

is-deeply(lr((
  (0,0,0,1,1,1),
  (1,1,1,1,1,1),
  (0,0,1,0,0,1),
  (0,0,1,1,1,1),
  (0,0,1,1,1,1),
    )),
          [
            (1,1,1,1),
            (1,1,1,1),
              ],
          'example 3');

sub lr(@s) {
  my $maxx=@s.end;
  my $maxy=@s[0].end;
  my $maxa=0;
  my @c;
  for (0..$maxx-1) -> $x {
    for (0..$maxy-1) -> $y {
      if (@s[$x][$y]==1) {
        for ($x+1..$maxx) -> $tx {
          for ($y+1..$maxy) -> $ty {
            my $valid=1;
          OL:
            for ($x..$tx) -> $sx {
              for ($y..$ty) -> $sy {
                if (@s[$sx][$sy] != 1) {
                  $valid=0;
                  last OL;
                }
              }
            }
            if ($valid) {
              my @l=($tx-$x+1,$ty-$y+1);
              my $a=@l[0]*@l[1];
              if ($a > $maxa) {
                $maxa=$a;
                @c=@l;
              }
            }
          }
        }
      }
    }
  }
  if (@c) {
    my @o;
    for (1..@c[0]) {
      push @o,(1 xx @c[1]).List;
    }
    return @o;
  }
  return 0;
}
