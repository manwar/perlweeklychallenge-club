#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
Submitted by: Mohammad Sajid Anwar
You are given an array of numbers.

Write a script to find all proper subsets with more than one element where the sum of elements equals the sum of their indices.

￼

=end comment

my @Test =
(2, 1, 4, 3),       ((2, 1), (1, 4), (4, 3), (2, 3),),
(3, 0, 3, 0),       ((3, 0), (3, 0, 3),),
(5, 1, 1, 1),       ((5, 1, 1),),
(3, -1, 4, 2),      ((3, 2), (3, -1, 4),),
(10, 20, 30, 40),   (),
;
plan +@Test ÷ 2;

sub task( @a -->Array) {
    my @key = ^@a;
    my @ret;
    for @key.combinations(2..^@key) -> @candi {
        if @candi.sum + @candi == @a[@candi].sum {     # index origin ONE
            @ret.push: @a[@candi]
        }
    }
    @ret
}

for @Test -> @in, @exp {
    is task( @in).sort, @exp.sort, "@exp.sort.raku() <- @in.raku()";
}
done-testing;

my @num = 2, 1, 4, 3, 7, 6;
say qq{\nInput: @num = (@num.join(' ,'))\nOutput: }, task( @num); 

