#!/usr/bin/raku

sub MAIN() {
    my @dna = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG'.comb;

    for @dna.classify({ $_; }).pairs.sort.map({ $_.key => $_.value.elems; }) -> $base {
        say $base;
    }

    my %complementaries = (
        'T' => 'A',
        'A' => 'T',
        'G' => 'C',
        'C' => 'G'
    );

    @dna.map({ %complementaries{$_}; }).join(q{}).say;
}