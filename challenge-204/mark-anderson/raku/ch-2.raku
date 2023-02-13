#!/usr/bin/env raku
use Test;

is-deeply reshape-matrix(1, 4, [[1,2], [3,4]]),     [[1,2,3,4],];
is-deeply reshape-matrix(3, 2, [[1,2,3], [4,5,6]]), [[1,2],[3,4],[5,6]];
nok       reshape-matrix(3, 2, [[1,2]]);

sub reshape-matrix($r, $c, @m)
{
    @m .= map(*.Slip);
    return 0 if $r * $c !== @m;
    @m.rotor($c).map(*.Array).Array
}    
