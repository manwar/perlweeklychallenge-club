#!/usr/bin/env raku
use Test;

is-deeply frequency-sort(1,1,2,2,2,3),          (3,1,1,2,2,2);
is-deeply frequency-sort(2,3,1,3,2),            (1,3,3,2,2);
is-deeply frequency-sort(-1,1,-6,4,5,-6,1,4,1), (5,-1,4,4,-6,-6,1,1,1);

sub frequency-sort(*@a)
{
    @a.Bag.sort({ $^a.value cmp $^b.value or $^b.key cmp $^a.key})
          .map({ .key xx .value })
          .flat
}
