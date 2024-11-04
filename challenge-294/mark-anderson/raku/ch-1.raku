#!/usr/bin/env raku
use Test;

# with help from https://www.geeksforgeeks.org/longest-consecutive-subsequence/

is cons-seq(10,4,20,1,3,2),       4;
is cons-seq(0,6,1,8,5,2,4,3,0,7), 9;
is cons-seq(10,30,20),            1;

sub cons-seq(+@ints)
{
    my $s = @ints.SetHash;

    .max given do for $s.keys -> $k
    {
        .elems given gather
        {
            for $k...-Inf 
            {
                $s{$_}-- or last;
                .take
            }

            for $k.succ...Inf
            {
                $s{$_}-- or last;
                .take 
            }
        }
    } 
}
