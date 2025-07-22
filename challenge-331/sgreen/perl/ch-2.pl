#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics qw(combinations);

sub main ( $source, $target ) {
    # Strings must be of the same length
    if ( length($source) != length($target) ) {
        say 'false';
        return;
    }

    my $iter = combinations( [ 0 .. length($source) - 1 ], 2 );
    while ( my $pair = $iter->next ) {
        my ( $i, $j ) = @$pair;
        # Swap characters at positions i and j in source
        my $swapped_word = $source;
        substr( $swapped_word, $i, 1, substr( $source, $j, 1 ) );
        substr( $swapped_word, $j, 1, substr( $source, $i, 1 ) );
        if ( $swapped_word eq $target ) {
            say 'true';
            return;
        }
    }

    say 'false';
}

main( $ARGV[0], $ARGV[1] );
