#!/usr/bin/env perl

# Write a program to find the sequence of characters that has the most anagrams.

use 5.026;
use strict;
use autodie;
use warnings;

my %anagrams;
my $max = 0;

# Read list of words and classify them by anagrams
while (<>) {
    chomp;
    my $count = ++$anagrams{join('', sort split //, lc $_)};
    $max = $count if $count > $max;
}

# Print all sequences of letters with most anagrams
while (my ($key, $words) = each %anagrams) {
    say $key if $words == $max;
}
