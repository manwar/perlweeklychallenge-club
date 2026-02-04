#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'sum';

sub main ($int) {
    my $persistence  = 0;
    my $digital_root = $int;

    # Keep iterating until we have a single digital
    while ( length($digital_root) > 1 ) {
        $digital_root = sum( split( //, $digital_root ) );
        $persistence++;
    }

    say "Persistence  = $persistence";
    say "Digital Root = $digital_root";
}

main( $ARGV[0] );
