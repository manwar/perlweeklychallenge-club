#!/usr/bin/env raku
use Test;

is third-max(5,6,4,1), 4;
is third-max(4,5),     5;
is third-max(1,2,2,3), 1;

sub third-max(+@ints)
{
    .[2] // .[0] given @ints.unique.sort(-*)
}
