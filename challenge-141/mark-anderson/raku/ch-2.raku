#!/usr/bin/env raku

use Test;
plan 4;

is like-numbers(1234, 2), 9, '1234, 2 = (2 4 12 14 24 34 124 134 234)';
is like-numbers( 768, 4), 3, ' 768, 4 = (8 76 68)';
is like-numbers(1008, 2), 6, '1008, 2 = (0 8 10 18 100 108)';
is like-numbers(7777, 7), 3, '7777, 7 = (7 77 777)';

sub like-numbers($m is copy, \n)
{
    $m .= comb;
    $m.combinations(1..^+$m).map(+*.join)
                            .grep(* %% n)
        	            .unique
			    .Int;
}
