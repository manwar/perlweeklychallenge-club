#!/usr/bin/env perl

use strict;
use warnings;

=head1 NAME

PWC 090 Challenge 1

=head1 SYNOPSIS

  $ ch-1.pl
  67
  CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC

=head1 DESCRIPTION

Given the DNA sequence,
GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG, this script
prints the nucleiobase count in the DNA sequence.  This script also prints the
complementary sequence where Thymine (T) on one strand is always facing an
adenine (A) and vice versa; guanine (G) is always facing a cytosine (C) and vice
versa.

=head1 AUTHORS

Joel Crosswhite E<lt>joel.crosswhite@ix.netcom.comE<gt>

=cut

my $DNA_SEQUENCE = 
    'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';
my %dna_complement = (
    'A' => 'T',
    'T' => 'A',
    'C' => 'G',
    'G' => 'C'
);

print length($DNA_SEQUENCE) . " bases\n";
print map { $dna_complement{$_} } split(//, $DNA_SEQUENCE);
print "\n";

exit 0;