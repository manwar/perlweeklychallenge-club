#!/bin/env raku

my \DNA = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';

# Task 1
my %nuclei-count;
DNA.comb.map({ ++%nuclei-count{ $_ } });
put "nucleiobase count:\n\t", %nuclei-count.gist;

# Task 2
put "the complementary sequence:\n\t{ with DNA { TR/TAGC/ATCG/ } }";
