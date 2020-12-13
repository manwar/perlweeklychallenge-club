#! /usr/bin/env raku

unit sub MAIN ($dna where $dna.chars > 0 && all($dna.comb) eq ('T' | 'A' | 'G' | 'C')
  = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG');

$dna.comb.Bag.sort({ $^a[0] cmp $^b[0] })>>.say;

say TR/TAGC/ATCG/ with $dna;
