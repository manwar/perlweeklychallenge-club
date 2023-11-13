#!/usr/bin/env raku
use Prime::Factor;

sub prime-order(@arr)
{
  @arr.sort: {my $fa = prime-factors($^a).elems;
	      my $fb = prime-factors($^b).elems;
	      $fa == $fb ?? $^a <=> $^b !! $fa <=> $fb}
}

say prime-order([11,8,27,4]);

