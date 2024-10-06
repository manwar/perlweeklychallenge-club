#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'shuffle';

sub shuffle_word($word) {
    # Shuffle the middle characters of the word
    my @middle = split //, substr( $word, 1, -1 );
    return
      substr( $word, 0, 1 ) . join( '', shuffle @middle ) . substr( $word, -1 );
}

sub main ($str) {
    # Split the string into a list of words
    my @word_list      = split( /([a-z]+)/i, $str );
    my $jumbled_phrase = '';

    foreach my $word (@word_list) {
        if ( $word =~ /[a-z]{4,}/ ) {
            # If the word has more than 3 letters, jumble the middle characters
            $jumbled_phrase .= shuffle_word($word);
        }
        else {
          # Otherwise, add the word as is (punctuation falls into this category)
            $jumbled_phrase .= $word;
        }
    }

    say $jumbled_phrase;
}

main( $ARGV[0] );