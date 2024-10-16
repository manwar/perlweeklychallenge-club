#!/usr/bin/env raku
use Test;

is middle-index(2,3,-1,8,4), 3;
is middle-index(1,-1,4),     2;
is middle-index(2,5),       -1;
is middle-index(2,-3,3),     0;

sub middle-index(+@a)
{
    my $left-sum  = 0;
    my $right-sum = @a.sum;
   
    for ^@a 
    {
        return $_ if $left-sum == $right-sum - @a.head;
        my $n = @a.shift;
        $left-sum  += $n;
        $right-sum -= $n
    }

    return -1
}
