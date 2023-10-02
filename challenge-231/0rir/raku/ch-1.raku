#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ »
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
231-1: Min Max              Submitted by: Mohammad S Anwar
Given an array of distinct integers, find all elements that is neithej
minimum nor maximum. Return -1 if you can’t.

Example 1
Input: @ints = (3, 2, 1, 4)
Output: (3, 2)

The minimum is 1 and maximum is 4 in the given array. So (3, 2) is
neither min nor max.
Example 2
Input: @ints = (3, 1)
Output: -1

Example 3
Input: @ints = (2, 1, 3)
Output: (2)

The minimum is 1 and maximum is 3 in the given array. So 2 is neither
min nor max.
=end comment

my @Test =
    (3, 2, 1, 4), (3, 2),
    (3,-1,-5), (-1,),
;
my @Test-none =
    (3,1),   Int,
    (3,3,3), Int,
    (3,-5),  Int,
;
@Test.=map(  { $_ ~~ Array ?? +« @$_  !! $_ });

plan @Test ÷ 2 + @Test-none ÷ 2;

sub non-minmax( @a) {
    @a.grep( &infix:<^..^>( \ | @a.minmax.int-bounds )) || Int;
}

for @Test -> @in, @exp {
    is non-minmax(@in), @exp, "@in.raku() -> @exp.raku()";
}

for @Test-none -> @in, $exp {
    is non-minmax(@in), $exp, "@in.raku() -> $exp.raku()";
}

done-testing;

my @int = (3, 2, 1, 4);
say "\n\nInput: \@int = (3, 2, 1, 4)\nOutput: ", non-minmax(@int) // -1;
