#!/usr/bin/env raku

use v6;

my $sequence = "GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG";

say nucleotide-count( $sequence );
say complement( $sequence );

sub nucleotide-count(  $sequence ) {
    my @cytosines = $sequence.comb;
    my @nucleotide;
    my $count = 0;
    
    for @cytosines -> $cytosine {
        @nucleotide.push($cytosine);
        if ( all( "G", "T", "A", "C" ) (elem) @nucleotide ) {
            $count++;
            @nucleotide = ();
        }     
    }
    return $count;
}

sub complement( $sequence ) {
    with $sequence { return TR/TAGC/ATCG/; }
}
