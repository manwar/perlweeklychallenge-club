#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub count_vowels ($s) {
    return $s =~ tr/aeiouAEIOU/aeiouAEIOU/;
}

sub string_alike ($input_string) {
    # Ensure the input string is of even length
    die "Input string must have an even length."
      if length($input_string) % 2 == 1;

    # If there are no vowels at all, return False
    if ( count_vowels($input_string) == 0 ) {
        say "False";
        return;
    }

    # Split the string into two halves, and count vowels in each half
    my $mid         = length($input_string) / 2;
    my $first_half  = substr( $input_string, 0, $mid );
    my $second_half = substr( $input_string, $mid );
    say count_vowels($first_half) == count_vowels($second_half)
      ? "True"
      : "False";
}

string_alike( $ARGV[0] );
