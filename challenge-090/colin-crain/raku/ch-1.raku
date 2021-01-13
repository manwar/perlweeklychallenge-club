#!/usr/bin/env perl6
#
#
#       dna.raku
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Str $seq = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG') ;

my %bases = $seq.comb.Bag;


## report
say qq:to/END/;
    seq:    $seq

    length  : {$seq.chars}
    thymine : %bases{'T'}
    adenine : %bases{'A'}
    guanine : %bases{'G'}
    cytosine: %bases{'C'}

    comp:   {TR/TAGC/ATCG/ with $seq}

    END

