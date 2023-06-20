#!/usr/bin/env raku

sub last-member(@arr)
{
  while (@arr.elems >= 2)
  {
    my ($f,$s) = @arr;
    @arr.splice(0,2);
    @arr.unshift($s-$f) if $f != $s;
  }
  @arr.elems
}

say last-member([2,7,4,1,8,1]);
say last-member([1]);
say last-member([1,1]);

