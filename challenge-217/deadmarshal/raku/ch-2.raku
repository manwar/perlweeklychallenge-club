#!/usr/bin/env raku

sub max-number(@arr)
{
  @arr.sort({"$^b$^a" cmp "$^a$^b"}).join;
}

say max-number([1,23]);
say max-number([10,3,2]);
say max-number([31,2,4,10]);
say max-number([5,11,4,1,2]);
say max-number([1,10]);

