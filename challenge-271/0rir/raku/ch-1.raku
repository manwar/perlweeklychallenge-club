#!/usr/bin/env raku
use v6.c;
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use Test;

=begin comment
271-1
=end comment

my @Test =
     [ [0, 1], [1, 0], ], 1,
     [ [0, 1, 1], [1, 0, 1], ], 1,
     [ [0, 0, 1], [1, 0, 1], ], 2,
     [ [1, 0, 1], [1, 0, 0], ], 1,
     [ [2, 0, 2], [0, 0, 0], ], Int,

;
plan @Test ÷ 2;

sub task( @a --> Int) {
   my @one-ct = @a.map( +*.grep(1));
   my $mx = @one-ct.max;
   return Int if $mx == 0;
   @one-ct.first( $mx, :k) + 1;

}

for @Test -> @in, $exp {
    is task(@in), $exp, "$exp.raku() <- @in.raku()";
}

done-testing;


