#!/usr/bin/env raku

sub separate-digits(@arr)
{
  @arr.map({.comb}).flat
}

say separate-digits([1,34,5,6]);
say separate-digits([1,24,51,60]);

