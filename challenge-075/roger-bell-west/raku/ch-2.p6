#! /usr/bin/perl6

use Test;

plan 2;

is(lrhist((2,1,4,5,3,7)),
   12,
   "example 1");

is(lrhist((3,2,3,5,7,5)),
   15,
   "example 2");

sub lrhist(@c) {
  my $bestarea=0;
  my @n=(0,0);
  for (0..@c.end-1) -> $a {
    for ($a+1..@c.end) -> $b {
      my $area=($b-$a+1)*min(@c[$a..$b]);
      if ($area>$bestarea) {
        $bestarea=$area;
        @n=($a,$b);
      }
    }
  }
  return $bestarea;
}
