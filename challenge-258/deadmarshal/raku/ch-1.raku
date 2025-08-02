#!/usr/bin/env raku

sub count-even-digits-number(@arr)
{
  @arr.grep({.comb.elems %% 2}).elems
}

say count-even-digits-number([10,1,111,24,1000]);
say count-even-digits-number([111,1,11111]);
say count-even-digits-number([2,8,1024,256]);

