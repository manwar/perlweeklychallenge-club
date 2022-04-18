#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $n = shift;
    # Numwbers as words
    my @words = ( 'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eigth', 'nine' );
    if ( $n !~ /^[0-9]$/ ) {
        die "The input must be an integer between 0 and 9\n";
    }

    my @phrases = ();

    while ( $n != 4 ) {
        my $l = length( $words[$n] );
        push @phrases, "$words[$n] is $words[$l]";

        # Check the next phrase
        $n = $l;
    }

    push @phrases, 'four is magic.';

    say ucfirst join ', ', @phrases;
}

main(@ARGV);