#!/usr/bin/env raku
use Test;

is-deeply check-order(5,2,4,3,1), (0,2,3,4);
is-deeply check-order(1,2,1,1,3), (1,3);
is-deeply check-order(3,1,3,2,3), (0,1,3);

sub check-order(+@ints)
{
    (@ints Z== @ints.sort).grep({ not .so }, :k)
}
