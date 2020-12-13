#!/usr/bin/perl
# The Weekly Challenge - Perl & Raku - 090
# Task 1: DNA seq
# Usage: ch-1.pl $S

use strict;
use warnings;

sub dna {
    my $seq = $_[0];
    my ($seqC, $seqG, $seqA, $seqT, $seqtemp) = ($seq) x 5;
    $seqC =~ s/[GAT]//g;
    $seqG =~ s/[CAT]//g;
    $seqA =~ s/[GCT]//g;
    $seqT =~ s/[GAC]//g;
    print "C: ", length $seqC, "\n", "G: ", length $seqG, "\n";
    print "A: ", length $seqA, "\n", "T: ", length $seqT, "\n";
    $seqtemp =~ tr/TAGC/ATCG/;
    print "\n";
    print "the complementary sequence:\n", $seqtemp, "\n";
}

my $S = "GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG";

$S = $ARGV[0] if ($ARGV[0]);
dna($S);



# Test data
# GTAAACC    -> C:2 G:1 A:3 T:1  CATTTGG
# GATGTGTT   -> C:0 G:3 A:1 T:4  CTACACAA
