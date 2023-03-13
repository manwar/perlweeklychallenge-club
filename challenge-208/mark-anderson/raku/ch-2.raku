#!/usr/bin/env raku
use Algorithm::Diff;
use Test;

is-deeply duplicate-and-missing(1,2,2,4),     (2,3);
is-deeply duplicate-and-missing(1,2,3,4),        -1;
is-deeply duplicate-and-missing(1,2,3,3),     (3,4);
is-deeply duplicate-and-missing(4,5,6,7,7,8), (7,9);
is-deeply duplicate-and-missing(4,5,6,7,7,9), (7,8);

# Algorithm::Diff 
is-deeply diff-module(1,2,2,4),     ("2", "3");
is-deeply diff-module(1,2,3,4),     (Nil, Nil);
is-deeply diff-module(1,2,3,3),     ("3", "4");
is-deeply diff-module(4,5,6,7,7,8), ("7", "9");
is-deeply diff-module(4,5,6,7,7,9), ("7", "8");

sub duplicate-and-missing(*@nums)
{
    given @nums
    {
        my @range = .head .. .head + .end;
        flat .repeated, keys @range (-) $_ or -1  
    }
}

sub diff-module(*@nums)
{
    my @range = .head .. .head + .end given @nums;
    diff(@nums, @range).comb(/\d+/)[1,3]
}
