#!/usr/bin/env raku

use Test;
plan 2;

my @m = [  1,  2,  3,  5,  7 ],
        [  9, 11, 15, 19, 20 ],
        [ 23, 24, 25, 29, 31 ],
        [ 32, 33, 39, 40, 42 ],
        [ 45, 47, 48, 49, 50 ];

is search-matrix(35, @m), 0, "Example 1";
is search-matrix(39, @m), 1, "Example 2";

sub search-matrix($n, @m)
{
    +($n ∈ first { .tail ≥ $n }, @m) 
}
