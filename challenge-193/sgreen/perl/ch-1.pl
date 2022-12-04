#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($n) {
    # The format we want (a binary string of a given length)
    my $fmt = "\%0${n}b";
    say $fmt;
    # Make a list with all possible binary values
    my @l = ( map { sprintf( $fmt, $_ ) } ( 0 .. 2**$n - 1 ) );

    # Show the list
    say join( ', ', @l );
}

main( $ARGV[0] );