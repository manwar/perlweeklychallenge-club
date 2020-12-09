#!/usr/bin/env perl
# For sequences of DNA get nucleotide counts and its complement

use strict;
use warnings;
use v5.10;

use List::Util qw(sum0);

# Receive sequences as strings in @ARGV
say('Usage: ch-1.pl sequence1 sequence2 ...'), exit 1 unless @ARGV;

my %complement_of; # Map dna nucleotide to its complement
@complement_of{my @nucleotides=qw(T A G C)}=qw(A T C G); #initialize

foreach my $sequence(map {uc} @ARGV){
    say("Wrong sequence $sequence"), next unless $sequence=~/^[@nucleotides]*$/;
    say "  Sequence: $sequence";
    say "Complement: ", complement($sequence);
    my %count_for=get_count_for($sequence);
    say "Nucleotide counts:";
    say "\t$_-$complement_of{$_} $count_for{$_}" for @nucleotides;
    say "\tTotal\t", sum0 values %count_for;
}

sub complement { # converts string with a DNA sequence to its complement
    my $sequence=shift;
    return join "", map {$complement_of{$_}} split //, $sequence;
}

sub get_count_for { # count nucleotides of a dna sequence
    my $sequence=shift;
    my @nucleotides=split //,$sequence;
    my %count_for; # counts of nucleotides
    @count_for{split //, "TAGC"}=((0) x 4); #initialize with 0's
    map {$count_for{$_}++} split //, $sequence;
    return %count_for;
}

# Sample run:
#
# $ ./ch-1.pl hithere \
# GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG \
# TGCTGGTCGCCG
#
# yields:
#
# Wrong sequence HITHERE
#   Sequence: GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG
# Complement: CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC
# Nucleotide counts:
#         T-A 22
#         A-T 14
#         G-C 13
#         C-G 18
#         Total   67
#   Sequence: TGCTGGTCGCCG
# Complement: ACGACCAGCGGC
# Nucleotide counts:
#         T-A 3
#         A-T 0
#         G-C 5
#         C-G 4
#         Total   12
