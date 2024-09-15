#!/usr/bin/env raku

sub order-game(@arr)
{
  while (@arr > 2) {
    my @t;
    for @arr -> $a,$b,$c,$d {
      @t.push: ($a,$b).min,($c,$d).max
    }
    @arr = @t;
  }
  @arr.min
}

say order-game([2,1,4,5,6,3,0,2]);
say order-game([0,5,3,2]);
say order-game([9,2,1,4,5,6,0,7,3,1,3,5,7,9,0,8]);

