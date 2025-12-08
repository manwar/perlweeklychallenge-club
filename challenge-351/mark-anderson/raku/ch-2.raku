#!/usr/bin/env raku
use Test;

ok  arithmetic-progression(1,3,5,7,9);
ok  arithmetic-progression(9,1,7,5,3);
nok arithmetic-progression(1,2,4,8,16);
ok  arithmetic-progression(5,-1,3,1,-3);
ok  arithmetic-progression(1.5,3,0,4.5,6);

sub arithmetic-progression(*@ints)
{
    @ints .= sort;    
    @ints ~~ (@ints[0],@ints[1]...*).head(@ints)
}
