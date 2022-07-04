#!/usr/bin/env raku
use Test;

is-deeply prime-partition(18, 2), ((5, 13), (7, 11));
is-deeply prime-partition(19, 3), ((3, 5, 11),);
is-deeply prime-partition(45, 5), ((3, 5, 7, 11, 19), (3, 5, 7, 13, 17));
is-deeply prime-partition(95, 8), ((2, 3, 5, 7, 11, 13, 17, 37), 
                                   (2, 3, 5, 7, 11, 13, 23, 31), 
                                   (2, 3, 5, 7, 11, 17, 19, 31), 
                                   (2, 3, 5, 7, 13, 17, 19, 29), 
                                   (2, 3, 7, 11, 13, 17, 19, 23));

sub prime-partition($m, $n)
{
    (2,3,5,7...$m-2).grep(&is-prime).combinations($n).grep({ .sum == $m })
}
