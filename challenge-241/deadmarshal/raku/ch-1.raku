#!/usr/bin/env raku

sub arithmetic-triplets(@arr,$diff)
{
  my $count = 0;
  for @arr.combinations(3)
  {
    $count++ if $_[1] - $_[0] == $diff == $_[2] - $_[1]
  }
  $count
}

say arithmetic-triplets([0,1,4,6,7,10],3);
say arithmetic-triplets([4,5,6,7,8,9],2);

