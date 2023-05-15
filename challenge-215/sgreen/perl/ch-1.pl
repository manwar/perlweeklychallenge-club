#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'any';

sub main (@words) {
    my $current_word   = shift @words;
    my $unsorted_words = 0;

    if ( any { $_ lt $current_word } @words ) {
        # If the first word is not the smallest, the whole list is unsorted
        say $#words + 2;
        return;
    }

    foreach my $word (@words) {
        if ( $word ge $current_word ) {
            # The next word is in order
            $current_word = $word;
        }
        else {
            # The word is less than the current word
            $unsorted_words++;
        }
    }

    say $unsorted_words;
}

main(@ARGV);