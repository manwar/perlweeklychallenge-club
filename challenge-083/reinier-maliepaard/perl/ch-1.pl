#!/usr/bin/perl
use strict;
use warnings;

sub words_length {

    my ($str) = @_;

    # Extract all non-whitespace sequences (words)
    my @words = ($str =~ /\S+/g);

    # Validate input: must have 3 or more words
    die "Input must have 3 or more words\n" if @words < 3;

    # Remove first and last words
    shift(@words);
    pop(@words);

    # Concatenate remaining words (no space) and return their length
    return length(join('', @words));
}

# Tests

my $S;

# Example 1:
$S = "The Weekly Challenge";
print words_length($S), "\n"; # Output: 6


# Example 2:
$S = "The purpose of our lives is to be happy";
print words_length($S), "\n"; # Output: 23
