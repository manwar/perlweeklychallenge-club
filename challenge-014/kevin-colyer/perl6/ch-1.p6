#!/usr/bin/perl6
use v6;

use Test;

# challenge 14.1
# Write a script to generate Van Eck’s sequence.
my @testEck=0, 0, 1, 0, 2, 0, 2, 2, 1, 6, 0, 5, 0, 2, 6, 5, 4, 0, 5;
is vanEck(17),@testEck,"First 18 items Van Eck's sequence correct";

sub vanEck(int $n where $n>=0 ) {
    # Let a0 = 0. Then, for n ≥ 0, if there exists an m < n such that am = an, take the largest such m and set an+1 = n − m; otherwise an+1 = 0.

    my int $max_m=-1; # set to a value lower than 0 to raise max_m
    state int @a=0;

    return 0 if $n==0; # base case

    vanEck($n-1) if @a[$n]:!exists;

    for 0..^$n -> int $m {
        if @a[$m]==@a[$n] {
            $max_m=max($max_m,$m);
        }
    }
    if $max_m>=0 {
        @a[$n+1]=$n-$max_m;
        return @a;
    }
    @a[$n+1]=0;
    return @a;
}

