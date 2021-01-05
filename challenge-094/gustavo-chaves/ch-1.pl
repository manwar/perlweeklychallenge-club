#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-094/

use 5.030;
use warnings;

my @input = ("opt", "bat", "saw", "tab", "pot", "top", "was");

my %anagrams;

foreach (@input) {
    my $key = join '', sort split //;
    push @{$anagrams{$key}}, $_;
}

say foreach map {join ', ', @$_} values %anagrams;
