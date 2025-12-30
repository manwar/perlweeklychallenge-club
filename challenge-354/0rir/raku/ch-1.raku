#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
INIT $*RAT-OVERFLOW = FatRat;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
May be edited for space.
354-Task 1: Min Abs Diff
You are given an array of distinct integers.

Write a script to find all pairs of elements with the minimum absolute difference.
=end comment

my @Test =
    (4, 2, 1, 3),           [[1, 2], [2, 3], [3, 4],],
    (10, 100, 20, 30),      [[10, 20], [20, 30],],
    (-5, -2, 0, 3),         [[-2, 0],],
    (8, 1, 15, 3),          [[1, 3],],
    (12, 5, 9, 1, 15),      [[9, 12], [12, 15],],
;
plan +@Test ÷ 2;

sub task( $a -->Array) {
    my @ret;
    my $minimus = ∞;
    # sort into overlapping pairs, each prefixed with their abs-diff
    my @work = $a.sort.rotor( 2 => -1).map: { [ .[1] - .[0], .[0], .[1] ]};

    for @work -> @e {
        given @e[0] <=> $minimus { 
            when Less { @ret =     [ @e[1,2].Array, ];  $minimus = @e[0]; }
            when Same { @ret.push:   @e[1,2].Array   ;                    }
        }
    }
    @ret;
}

for @Test -> @in, @exp {
    is task( @in), @exp, "{@exp // @exp.^name()} <- @in.raku()";
}
done-testing;

#=finish
my @int = (12, 5, 9, 1, 15);
say qq{\nInput: @int = (@int.join(', '))\nOutput:}, task( @int).join( ', ' );
