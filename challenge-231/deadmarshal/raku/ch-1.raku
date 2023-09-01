#!/usr/bin/env raku

sub min-max(@arr)
{
  my ($min,$max) = (@arr.min,@arr.max);
  @arr.grep:{$_ != $min && $_ != $max}
}

say min-max([3,2,1,4]);
say min-max([3,1]);
say min-max([2,1,3]);

