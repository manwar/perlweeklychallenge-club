#!/usr/bin/env raku

sub build_array(@arr)
{
  @arr[@arr]
}

say build_array([0,2,1,5,3,4]);
say build_array([5,0,1,2,3,4]);

