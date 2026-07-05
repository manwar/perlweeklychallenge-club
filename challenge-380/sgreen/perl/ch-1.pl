#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    # Compute the frequency of each letter
    my %freq = ();
    $freq{$_}++ foreach ( split //, $input_string );

    # Update the max_vowels and max_consonants as required
    my $max_vowels     = 0;
    my $max_consonants = 0;
    while ( my ( $letter, $count ) = each %freq ) {
        if ( index( "aeiou", $letter ) != -1 ) {
            if ( $count > $max_vowels ) {
                $max_vowels = $count;
            }
        }
        else {
            if ( $count > $max_consonants ) {
                $max_consonants = $count;
            }
        }
    }

    # Return the sum of these two numbers
    say $max_vowels + $max_consonants;

}

main(@ARGV);
