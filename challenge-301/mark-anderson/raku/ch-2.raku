#!/usr/bin/env raku
use Test;

is hamming-distance(4,14,2),                                              6;
is hamming-distance(4,14,4),                                              4;
is hamming-distance(1389,3325,1768,3498,3557,6377,4589,1578,8691,1958), 262;
is hamming-distance(5231, 761,7461,   2,7589,1695, 214,8141,8038,6092), 303;
is hamming-distance(9091,6716,5601,1788,7295, 449,7894,2352,8714,1060), 334;

sub hamming-distance(+@ints)
{
    sum @ints.combinations(2).map(-> ($a, $b) 
    {
        ($a +^ $b).base(2).indices(1)
    })
}
