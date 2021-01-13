#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-090/

# Also see: https://andrewshitov.com/2019/09/09/dna-to-rna-transcription-in-perl-6/

my $dna = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';

put $dna.comb.Bag; # T(22) C(18) A(14) G(13)

# In the task it is said that A reflects to T, which is weird.
say $dna.trans('TAGC' => 'AUCG'); # CAUUUGGGGAAAAGUAAAUCUGUCUAGCUGAGGAAUAGGUAAGAGUCUCUACACAACGACCAGCGGC
