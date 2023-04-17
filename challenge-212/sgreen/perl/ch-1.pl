#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'any';
use List::MoreUtils 'first_index';

sub main (@array) {
    my @original_word  = split //, shift(@array);
    my $lower_alphabet = [ 'a' .. 'z' ];
    my $upper_alphabet = [ 'A' .. 'Z' ];
    my $new_word       = '';

    while ( my ( $i, $original_letter ) = each(@original_word) ) {
        # Which alphabet?
        my $alphabet =
          ( any { $_ eq $original_letter } @$lower_alphabet )
          ? $lower_alphabet
          : $upper_alphabet;

        # Calculate position of new letter
        my $pos =
          ( ( first_index { $_ eq $original_letter } @$alphabet ) + $array[$i] )
          % 26;

        # ... and add it to the string
        $new_word .= $alphabet->[$pos];
    }

    say $new_word;
}

main(@ARGV);