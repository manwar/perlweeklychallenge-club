#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@array) {
    my $input_string = lc shift @array;
    my @broken_keys  = map { lc } @array;

    my $completed_words = 0;
    for my $word ( split ' ', $input_string ) {
        if ( not grep { index( $word, $_ ) != -1 } @broken_keys ) {
            $completed_words++;
        }
    }

    say $completed_words;
}

main(@ARGV);
