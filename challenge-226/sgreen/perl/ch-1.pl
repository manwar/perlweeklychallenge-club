#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # The first value is the word
    my $word     = shift @ints;
    my $solution = ' ' x length($word);

    # Put the values in the right place
    foreach my $i ( 0 .. $#ints ) {
        substr( $solution, $ints[$i], 1, substr( $word, $i, 1 ) );
    }

    # Print solution
    say $solution;
}

main(@ARGV);