#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@sentences) {
    my $max_words = 0;

    # Iterate through each sentence
    foreach my $sentence (@sentences) {
        # Trim leading and trailing whitespace
        $sentence =~ s/^\s+|\s+$//g;

        # Count words in the sentence, update max_words if necessary
        my $word_count = split( /\s+/, $sentence );
        if ( $word_count > $max_words ) {
            $max_words = $word_count;
        }
    }

    # Return the maximum word count found
    say $max_words;
}

main(@ARGV);
