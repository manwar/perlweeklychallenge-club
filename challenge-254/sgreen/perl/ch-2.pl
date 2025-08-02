#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub reverse_vowels ($s) {
    # Convert it to lower case
    $s = lc $s;

    # Extract the vowels
    my @vowel_list = grep { /[aeiou]/ } split //, $s;

    for my $pos ( 0 .. length($s) - 1 ) {
        # If the character here is a vowel
        if ( substr( $s, $pos, 1 ) =~ /[aeiou]/ ) {
            # ... get the last vowel
            substr( $s, $pos, 1 ) = pop(@vowel_list);
        }
    }

    return ucfirst $s;
}

say reverse_vowels($ARGV[0]);