#!/usr/bin/env raku
use Test;

is most-frequent-even(1,1,2,6,2), 2;
is most-frequent-even(1,3,5,7),   Inf;
is most-frequent-even(6,4,4,6,1), 4;

sub most-frequent-even(*@list)
{
    @list.grep(* %% 2).Bag.maxpairs>>.key.min
}    
