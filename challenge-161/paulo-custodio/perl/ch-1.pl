#!/usr/bin/env perl

# Challenge 161
#
# Task 1: Abecedarian Words
# Submitted by: Ryan J Thompson
# An abecedarian word is a word whose letters are arranged in alphabetical
# order. For example, “knotty” is an abecedarian word, but “knots” is not.
# Output or return a list of all abecedarian words in the dictionary, sorted
# in decreasing order of length.
#
# Optionally, using only abecedarian words, leave a short comment in your code
# to make your reviewer smile.

use Modern::Perl;

my %out;
while (<>) {
    chomp(my $word = $_);
    next if length($word)<3;
    my $abcd_word = join('', sort split(//, lc($word)));
    $out{$word}=1 if $word eq $abcd_word;
}

say join("\n", sort {length($b)<=>length($a)} sort keys %out);
