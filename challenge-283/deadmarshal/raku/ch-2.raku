#!/usr/bin/env raku

sub digit-count-value(@arr)
{
  @arr.pairs.Bag eqv @arr.Bag
}

say digit-count-value([1,2,1,0]);
say digit-count-value([0,3,0]);

