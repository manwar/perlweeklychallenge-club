#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub divmod ( $num, $div ) {
    # Perl doesn't have a built-in divmod function
    return int( $num / $div ), $num % $div;
}

sub main ($num) {
    my @digits = ();
    my $rem;

    while ( $num >= 4 or $num < 0 ) {
        ( $num, $rem ) = divmod( $num, -4 );

        if ( $rem < 0 ) {
            $num += 1;
            $rem += 4;
        }

        unshift @digits, $rem;
    }

    unshift @digits, $num;

    # The actual solution is the number reversed, separated by zeros
    say join( '0', @digits );
}

main(@ARGV);
