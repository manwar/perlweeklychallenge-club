#!/usr/bin/env raku
'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG'.&{
    say 'Nucleiobase count: ' ~ .comb.elems;
    say 'Complementary sequence: ' ~ TR/TAGC/ATCG/;
}
