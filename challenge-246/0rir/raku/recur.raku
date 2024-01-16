#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;

sub MAIN( *@in ) {
    my ($p, $q, @a) = @in».Int;

    for ^3 {
        @a.push: $p × @a[*-2] + $q × @a[*-1];
    }

    say "P $p   Q $q   Ary:  @a.raku()";
}

