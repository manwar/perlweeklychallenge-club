#!/usr/bin/env raku

use v6;

my $sequence = "GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG";

say nucleotide-count( $sequence );
say complement( $sequence );

sub nucleotide-count(  $sequence ) {
    return $sequence.comb.Bag.pairs.sort( *.value ).reverse.map( -> $p { "{$p.key} : {$p.value}" } ).join("\n"); 
}

sub complement( $sequence ) {
    with $sequence { return TR/TAGC/ATCG/; }
}
