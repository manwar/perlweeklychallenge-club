#!/usr/bin/env raku

sub zero-array(@arr)
{
  my %hash = @arr.grep(* > 0).map({$_ => 1});
  %hash.elems
}

say zero-array([1,5,0,3,5]);
say zero-array([0]);
say zero-array([2,1,4,0,3]);

