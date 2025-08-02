#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
271-2
=end comment

my @Test =
    [0, 1, 2, 3, 4, 5, 6, 7, 8],    [0, 1, 2, 4, 8, 3, 5, 6, 7],
    [1024, 512, 256, 128, 64],      [64, 128, 256, 512, 1024],
;
plan @Test ÷ 2;

sub task( @a) {
        @a.sort( { .base(2).comb.grep("1"), .Int }).List;
}

for @Test -> @in, @exp {
    is task(@in), @exp, "@exp[] <- @in[]";
}

done-testing;


