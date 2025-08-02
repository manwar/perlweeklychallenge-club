#!/usr/bin/env raku
use Test;

is product-sign(-1,-2,-3,-4,3,2,1), 1;
is product-sign(1,2,0,-2,-1),       0;
is product-sign(-1,-1,1,-1,2),     -1;
is product-sign(1,2,3),             1;

sub product-sign(*@ints)
{
    my %sign is Map = @ints.classify(*.sign);

    return 0 if %sign{0};
    return 1 unless %sign{-1};
    return +(%sign{-1} %% 2) || -1
}
