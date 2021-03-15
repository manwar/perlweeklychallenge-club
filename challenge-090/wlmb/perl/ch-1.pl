#!/usr/bin/env perl
# For sequences of DNA get nucleotide counts and its complement
# See https://wlmb.github.io/2020/12/07/PWC90/#task-1-dna-sequence
use strict;
use warnings;
use v5.10;

use List::Util qw(sum0);

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
    @count_for{qw(T A G C)}=((0) x 4); #initialize with 0's
    map {$count_for{$_}++} split //, $sequence;
    return %count_for;
}
