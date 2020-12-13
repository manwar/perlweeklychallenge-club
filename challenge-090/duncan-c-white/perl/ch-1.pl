#!/usr/bin/perl
#
# Task 1: "DNA Sequence
# 
# DNA is a long, chainlike molecule which has two strands twisted into
# a double helix. The two strands are made up of simpler molecules
# called nucleotides. Each nucleotide is composed of one of the four
# nitrogen-containing nucleobases cytosine (C), guanine (G), adenine (A)
# and thymine (T).
# 
# You are given DNA sequence, GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG.
# 
# Write a script to print nucleobase count in the given DNA sequence. Also
# print the complementary sequence where Thymine (T) on one strand is
# always facing an adenine (A) and vice versa; guanine (G) is always facing
# a cytosine (C) and vice versa.
# 
# To get the complementary sequence use the following mapping:
# 
# T => A
# A => T
# G => C
# C => G
# "
# 
# My notes: very clearly defined, simple to do.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug = 0;
die "Usage: dna [--debug] sequence\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV==1;
my $seq = shift;

my %freq;
my $comp = "";
my %comp = qw(T A A T G C C G);
@freq{keys %comp} = (0) x (keys %comp);

$seq =~ tr/ATCG//cd;
foreach my $base (split(//,$seq))
{
	$freq{$base}++;
	$comp .= $comp{$base};
}
say "complement: $comp";
say "freq{$_} = $freq{$_}" for sort keys %comp;
