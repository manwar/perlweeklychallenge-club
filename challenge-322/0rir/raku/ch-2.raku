#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.e.PREVIEW;
use Test;

die 'Need rakudo version 2023.08 or later.' 
    unless $*RAKU.compiler.version ≥ v2023.08;


=begin comment
322-2: Rank Array       Submitted by: Mohammad Sajid Anwar
You are given an array of integers.

Write a script to return an array of the ranks of each element: the lowest value has rank 1, next lowest rank 2, etc. If two elements are the same then they share the same rank.


Example 1
Input: @ints = (55, 22, 44, 33)
Output: (4, 1, 3, 2)

Example 2
Input: @ints = (10, 10, 10)
Output: (1, 1, 1)

Example 3
Input: @ints = (5, 1, 1, 4, 3)
Output: (4, 1, 1, 3, 2)

=end comment

my @Test =
    (55, 22, 44, 33),   (4, 1, 3, 2),
    (10, 10, 10),       (1, 1, 1),
    (5, 1, 1, 4, 3),    (4, 1, 1, 3, 2),
;

plan @Test ÷ 2;

sub task( @in -->List) {
    my @w = @in.Array;                              # List to Array
    my %m = @w.sort.squish.antipairs.Array;         # map value to rank
    for 0..^@w -> \i {                              # use the map
        @w[i] = %m{@w[i]}+1;
    }
    @w.List;
}

for @Test -> @in, @exp {
    is-deeply task( @in), @exp, "@exp[] <- @in[]";
}
done-testing;

my @int = (5, 1, 1, 4, 3, 1, 1, 3, 5);

say qq{\nInput: @int = @int[]\nOutput: &task(@int)};

