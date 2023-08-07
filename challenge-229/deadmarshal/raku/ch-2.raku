#!/usr/bin/env raku

sub two-out-of-three(@arr)
{
  my %hash;
  @arr.map({%hash{$_}++ for $_.unique});
  %hash.keys.grep({%hash{$_} >= 2}).sort()
}

say two-out-of-three([[1,1,2,4],[2,4],[4]]);
say two-out-of-three([[4,1],[2,4],[1,2]]);

