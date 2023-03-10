#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

# Read in the list of letters
my $letters = shift;
my %letter_counts;
for my $char ( split '', lc $letters ) {
    $letter_counts{$char}++;
}

# Read in the file of words and print out the matching ones
while ( my $word = <> ) {
    chomp $word;
    my %word_counts;
    for my $char ( split '', lc $word ) {
        $word_counts{$char}++;
    }
    my $matches = 1;
    for my $char ( keys %word_counts ) {
        unless ( $word_counts{$char} <= $letter_counts{$char} ) {
            $matches = 0;
            last;
        }
    }
    print "$word\n" if $matches;
}
