#!/usr/bin/perl

# Challenge 090
# TASK #1 › DNA Sequence
# Submitted by: Mohammad S Anwar
# DNA is a long, chainlike molecule which has two strands twisted into a
# double helix. The two strands are made up of simpler molecules called
# nucleotides. Each nucleotide is composed of one of the four nitrogen-containing
# nucleobases cytosine (C), guanine (G), adenine (A) and thymine (T).
#
# You are given DNA sequence,
# GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG.
#
# Write a script to print nucleiobase count in the given DNA sequence.
# Also print the complementary sequence where Thymine (T) on one strand
# is always facing an adenine (A) and vice versa; guanine (G) is always
# facing a cytosine (C) and vice versa.

# Start the script with the ADN sequence in the command line.

# The solution uses a tr/// to replace each nucleiobase by its complement.

use strict;
use warnings;

my $seq = shift;
print length($seq), "\n";
(my $compl = $seq) =~ tr/TAGC/ATCG/;
print $compl, "\n";
