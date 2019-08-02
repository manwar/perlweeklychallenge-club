#!/usr/bin/env perl

# Write a program to find the sequence of characters that has the most anagrams.

use 5.026;
use strict;
use autodie;
use warnings;
use List::Util 'max';

my %anagrams;

# Read list of words and classify them by anagrams
while (<>) {
    chomp;
    my $key = join('', sort split //, lc $_);
    push @{$anagrams{$key}}, $_;
}

# Find out the cardinality of the biggest anagram set
my $max = max map {scalar @$_} values %anagrams;

# Print all sequences of letters with most anagrams
while (my ($key, $words) = each %anagrams) {
    say $key if @$words == $max;
}
