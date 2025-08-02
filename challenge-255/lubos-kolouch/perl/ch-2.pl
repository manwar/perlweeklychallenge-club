#!/usr/bin/perl
use strict;
use warnings;

sub most_frequent_word {
    my ($p, $w) = @_;
    my %word_count;

    # Clean and split the paragraph into words
    $p =~ s/[^\w\s]//g;
    my @words = split(/\s+/, lc $p);

    # Count the frequency of each word, excluding the banned word
    $word_count{$_}++ for grep { $_ ne $w } @words;

    # Find the most frequent word
    my $most_frequent = (sort { $word_count{$b} <=> $word_count{$a} } keys %word_count)[0];

    return $most_frequent;
}

# Test cases
print most_frequent_word("Joe hit a ball, the hit ball flew far after it was hit.", "hit"), "\n";
print most_frequent_word("Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.", "the"), "\n";
