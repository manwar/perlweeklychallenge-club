#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
310-1: Arrays Intersection      Submitted by: Mohammad Sajid Anwar
You are given a list of array of integers.

Write a script to return the common elements in all the arrays.

Example 1
Input: $list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
Output: (1, 4)
Example 2
Input: $list = ( [1, 0, 2, 3], [2, 4, 5] )
Output: (2)
Example 3
Input: $list = ( [1, 2, 3], [4, 5], [6] )
Output: ()
=end comment

my @Test =
    #    in                                        exp
    ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] ), (1, 4),
    ( [1, 0, 2, 3], [2, 4, 5] ),                  (2,),
    ( [1, 2, 3], [4, 5], [6] ),                   (),
    ( [4, 5], [6], [4,5], [] ),                   (),
    ( [], [6], [4,5], [] ),                       (),
;
plan @Test ÷ 2;

sub task( @a --> Array) { @ = ( [∩] @a).keys }

for @Test ->  @in, @exp {
    is task( @in).sort.Array, @exp, "{@exp // @exp.^name()} <- @in.raku()"
}
done-testing;

my $list =    ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] );
say "\nInput: \$list = @$list.raku()\nOutput: &task( $list).Array.raku()";
