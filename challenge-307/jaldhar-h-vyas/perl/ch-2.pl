#!/usr/bin/perl
use v5.38;

my @words = @ARGV;

my %anagrams;
foreach my $word (@words) {
    my $sorted = join q{}, sort split //, $word;
    $anagrams{$sorted}++;
}

say scalar %anagrams;
