#!/usr/bin/env raku
use Test;

is-deeply target-index((1,5,3,2,4,2), 2), (1,2); 
is-deeply target-index((1,2,4,3,5),   6), ();
is-deeply target-index((5,3,2,4,2,1), 4), (4,);

sub target-index(@ints, $k)
{
    @ints.sort.grep($k, :k)
}
