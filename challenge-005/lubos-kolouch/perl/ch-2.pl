#!/usr/bin/perl

use strict;
use warnings;

# This program finds the sequence of characters that has the most anagrams.

=head1 SYNOPSIS

This program finds the sequence of characters that has the most anagrams.

=cut

# Function to find the sequence of characters that has the most anagrams
sub find_most_anagrams {
    my ($str) = @_;

    # Create a hash to store all the anagrams
    my %anagrams;

    # Iterate over each substring of the given string
    for my $substring ( substrings($str) ) {

        # Sort the characters of the substring
        my $sorted_substring = join '', sort split //, $substring;

        # Add the substring to the anagrams hash
        push @{ $anagrams{$sorted_substring} }, $substring;
    }

    # Find the sequence with the most anagrams
    my $max_anagrams = 0;
    my $max_sequence = "";
    for my $sequence ( keys %anagrams ) {
        my $count = scalar @{ $anagrams{$sequence} };
        if ( $count > $max_anagrams ) {
            $max_anagrams = $count;
            $max_sequence = $sequence;
        }
    }

    return $max_sequence;
}

# Function to generate all substrings of a given string
sub substrings {
    my ($str) = @_;

    my @substrings;
    for my $i ( 0 .. length($str) - 1 ) {
        for my $j ( $i .. length($str) ) {
            push @substrings, substr( $str, $i, $j - $i );
        }
    }

    return @substrings;
}
