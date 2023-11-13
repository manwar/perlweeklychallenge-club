#!/usr/bin/env raku

sub reverse-pairs(@arr)
{
  my $count = 0;
  for @arr.combinations(2)
  {
    $count++ if $_[0] > ($_[1] * 2)
  }
  $count
}

say reverse-pairs([1,3,2,3,1]);
say reverse-pairs([2,4,3,5,1]);

