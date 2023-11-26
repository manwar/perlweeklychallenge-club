#!/usr/bin/env raku
use Test;

is arithmetic-triplets([0,1,4,6,7,10], 3), 2;
is arithmetic-triplets([4,5,6,7,8,9],  2), 2;

sub arithmetic-triplets(@a, $diff)
{
    + @a.combinations(3).grep(
      {
          [==] -$diff, |.rotor(2 => -1).map({ [-] $_ })
      })
}
