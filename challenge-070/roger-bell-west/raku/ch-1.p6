#! /usr/bin/perl6

use Test;

plan 1;

is(swap('perlandraku',3,4),
   'pndraerlaku',
   'example 1',
     );

sub swap($s,$c,$o) {
  my $n=$s.chars;
  my @s=$s.comb;
  for (1..$c) -> $ci {
    (@s[$ci % $n],@s[($ci+$o) % $n]) = (@s[($ci+$o) % $n],@s[$ci % $n]);
  }
  return join('',@s);
}
