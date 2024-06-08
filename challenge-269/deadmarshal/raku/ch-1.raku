#!/usr/bin/env raku

sub bitwise-or(@arr)
{
  (@arr.grep: {$_ +& 1 == 0}) > 1;
}

say bitwise-or([1,2,3,4,5]);
say bitwise-or([2,3,8,16]);
say bitwise-or([1,2,5,7,9]);

