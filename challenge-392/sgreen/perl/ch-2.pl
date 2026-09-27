#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use Algorithm::Combinatorics 'combinations';

sub unique_letters ( $word1, $word2 ) {
    # Check no letters appear in both words
    for my $letter ( split //, $word1 ) {
        return 0 if index( $word2, $letter ) != -1;
    }
    return 1;
}

sub main (@words) {
    my $max_length = 0;

    # Loop through each pair combination
    my $iter = combinations( \@words, 2 );
    while ( my $word_pairs = $iter->next() ) {
        my ( $word1, $word2 ) = @$word_pairs;
        # If the letters are unique, update the maximum_length if required
        if ( unique_letters( $word1, $word2 ) ) {
            my $length = length($word1) * length($word2);
            if ( $length > $max_length ) {
                $max_length = $length;
            }
        }
    }

    say $max_length;
}

main(@ARGV);
