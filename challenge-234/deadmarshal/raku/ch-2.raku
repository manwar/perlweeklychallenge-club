#!/usr/bin/env raku

sub unequal-triplets(@arr)
{
  my %h;
  %h{$_}++ for @arr;
  my @keys = %h.keys;
  @keys < 3 ?? 0 !! @keys.combinations(3).map({[*] %h{$_}}).sum;
}

say unequal-triplets([4,4,2,4,3]);
say unequal-triplets([1,1,1,1,1]);
say unequal-triplets([4,7,1,10,7,4,1,1]);

