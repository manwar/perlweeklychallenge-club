#!/usr/bin/env perl6
use v6;

sub MAIN(Str:D $stones, Str:D $jewels) {
    my $stone-set = $stones.comb.cache;
    my $matches   = $jewels.comb.grep: { $^a ∈ $stone-set };
    say $matches.elems;
}


