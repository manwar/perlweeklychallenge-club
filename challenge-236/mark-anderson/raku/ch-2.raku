#!/usr/bin/env raku
use Test;

is  array-loops([4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10]), 3;
is  array-loops([0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19]), 6;
is  array-loops([9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17]), 1;
say array-loops((^1e6).pick(*).Array);

sub array-loops(@a)
{
    sum do while @a
    {
        my $k = @a.first({ .defined }, :k);
        $k = @a[$k]:delete while $k.defined; 
        1
    }
}
