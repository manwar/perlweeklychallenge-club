#!/usr/bin/env raku

sub count-smaller(@arr)
{
  @arr.map: {my $e = $_; (@arr.grep: {$_ < $e}).elems}
}

say count-smaller([8,1,2,2,3]);
say count-smaller([6,5,4,8]);
say count-smaller([2,2,2]);

