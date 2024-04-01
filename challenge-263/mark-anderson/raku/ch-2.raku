#!/usr/bin/env raku
use Test;

is-deeply merge-items([[1,1],[2,1],[3,2]],       [[2,2],[1,3]]), ((1,4),(2,3),(3,2));
is-deeply merge-items([[1,2],[2,3],[1,3],[3,2]], [[3,1],[1,3]]), ((1,8),(2,3),(3,3));
is-deeply merge-items([[1,1],[2,2],[3,3]],       [[2,3],[2,4]]), ((1,1),(2,9),(3,3));

sub merge-items($i1, $i2)
{
    given (|$i1, |$i2).classify({.head}, :as{.tail})
    {
        sort .keys Z .values>>.sum
    }
}
