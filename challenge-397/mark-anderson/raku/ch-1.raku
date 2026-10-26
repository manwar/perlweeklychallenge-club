#!/usr/bin/env raku
use Test;

is asp(1,2,4,5,6),  7;
is asp(-5,-2,-1,3), 1;
is asp(1,2,3),      4;
is asp(2,3,7,8),    6;
is asp(1,1,1,10),   4;

sub asp(*@arr)
{
    my $n    = @arr.sum div @arr.elems + 1;
    my @ints = max(1,$n)..max(1,@arr.max + 1);
    (@ints (-) @arr).min.key
}
