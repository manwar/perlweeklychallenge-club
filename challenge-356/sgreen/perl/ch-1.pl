#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($int) {
    say int( ( $int + 1 ) / 2 );
}

main( $ARGV[0] );
