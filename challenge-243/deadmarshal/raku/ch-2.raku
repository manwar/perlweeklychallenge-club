#!/usr/bin/env raku

sub floor-sum(@arr)
{
  my $sum = 0;
  for @arr X @arr
  {
    $sum += $_[0] div $_[1];
  }
  $sum
}

say floor-sum([2,5,9]);
say floor-sum([7,7,7,7,7,7,7]);

