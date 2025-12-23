#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(any);

sub main (@words) {
    # Make a copy of the input words
    my @other_words = @words;

    # List of matching words
    my @matches = ();

    # Loop over each word
    while ( my ( $i, $word ) = each(@words) ) {
        # Skip if the word is already matched
        if ( any { $_ eq $word } @matches ) {
            next;
        }

        # Check if the word is a substring of any other word
        my $j = 0;
        foreach my $other_word (@other_words) {
            if ( $i != $j and index( $other_word, $word ) != -1 ) {
                push @matches, $word;
                last;
            }
            $j++;
        }
    }

    # Return the list of matching words
    say '(' . join( ', ', map { "\"$_\"" } @matches ) . ')';
}

main(@ARGV);
