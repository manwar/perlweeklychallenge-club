#!/usr/bin/perl

use strict;
use warnings;

sub print_anagrams {
    my $word = shift;
    my %freq;

    # Count the frequency of each letter in the word
    $freq{$_}++ for split //, $word;

    # Recursively generate all anagrams
    sub generate_anagrams {
        my ( $prefix, $freq_ref ) = @_;

        # Base case: no more letters left to add
        if ( length $prefix == length $word ) {
            print "$prefix\n";
            return;
        }

        # Recursive case: add one more letter to the prefix
        for my $letter ( keys %$freq_ref ) {
            if ( $freq_ref->{$letter} > 0 ) {
                $freq_ref->{$letter}--;
                generate_anagrams( $prefix . $letter, $freq_ref );
                $freq_ref->{$letter}++;
            }
        }
    }

    # Start generating anagrams with an empty prefix and the frequency hash
    generate_anagrams( "", \%freq );
}

# Test the function with some example words
print_anagrams("hello");
print_anagrams("pear");
print_anagrams("racecar");
