#! /usr/bin/perl6

use Test;

plan 3;

is(fs((
  [0,1,0,1],
  [0,0,1,0],
  [1,1,0,1],
  [1,0,0,1])),
   1,'example 1');

is(fs((
  [1,1,0,1],
  [1,1,0,0],
  [0,1,1,1],
  [1,0,1,1])),
   4,'example 2');

is(fs((
  [0,1,0,1],
  [1,0,1,0],
  [0,1,0,0],
  [1,0,0,1])),
   0,'example 3');

sub fs(@s) {
  my $t=0;
  my $maxx=@s.elems-1;;
  my $maxy=@s[0].elems-1;
  for (0..$maxx-1) -> $x {
    for (0..$maxy-1) -> $y {
      if (@s[$x][$y]==1) {
        for (1..min($maxx-$x,$maxy-$y)) -> $d {
          if (@s[$x+$d][$y]==1 &&
                @s[$x][$y+$d]==1 &&
                @s[$x+$d][$y+$d]==1
                  ) {
            $t++;
          }
        }
      }
    }
  }
  return $t;
}
