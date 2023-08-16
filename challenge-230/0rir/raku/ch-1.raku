#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
230-1: Separate Digits          Submitted by: Mohammad S Anwar
Given an array of positive integers, separate the given array into single
digits.

Example 1
Input: @ints = (1, 34, 5, 6)
Output: (1, 3, 4, 5, 6)
Example 2
Input: @ints = (1, 24, 51, 60)
Output: (1, 2, 4, 5, 1, 6, 0)

=end comment

my @Test =
    [,],            [,],
    [0,],           [0,],
    [1,34,5,6],     [1,3,4,5,6],
    [1,24,51,60],   [1,2,4,5,1,6,0],
    [1,1245160,0],  [1,1,2,4,5,1,6,0,0],
;

sub digitize( @i --> Array) { (@i.map( *.Str.comb )).flat.map( *.Int).Array; }

plan 1 + @Test ÷ 2 ;

for @Test -> @in, @exp {
    is digitize(@in), @exp, "@exp.raku() <- @in.raku()";
}
is digitize([1,1] )[0].WHAT, Int, 'Type';

done-testing;

my @int = [1, 34, 5, 6];
say "\nInput: @int = @int.raku()\nOutput: ", digitize( @int).raku();

exit;

