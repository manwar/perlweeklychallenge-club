#!/usr/bin/env raku
use Test;

is hamming-distance(4,14,2), 6;
is hamming-distance(4,14,4), 4;

sub hamming-distance(+@ints)
{
    .sum given @ints.combinations(2).map(-> ($a, $b) 
    {
        ($a +^ $b).base(2).indices(1)
    })
}
