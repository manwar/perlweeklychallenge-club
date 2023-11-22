#!/usr/bin/env raku

sub group-hero(@arr)
{
  my $sum = 0;
  for @arr.combinations
  {
    next unless .elems;
    $sum += (.max ** 2) * .min;
  }
  $sum
}

say group-hero([2,1,4]);

