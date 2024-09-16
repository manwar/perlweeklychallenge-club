#!/usr/bin/env raku

sub unique-number(@arr)
{
  @arr (-) @arr.repeated
}

say unique-number([3,3,1]);
say unique-number([3,2,4,2,4]);
say unique-number([1]);
say unique-number([4,3,1,1,1,4]);

