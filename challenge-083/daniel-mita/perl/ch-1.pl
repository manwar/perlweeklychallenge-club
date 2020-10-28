#!/usr/bin/env perl

use strict;
use warnings;
use feature qw<say>;

my @words = split( /\s+/, $ARGV[0] // '' );
if ( @words >= 3 ) {
    say scalar( split( //, join( '', @words[ 1 .. $#words - 1 ] ) ) );
}
else {
    say 'Fewer than 3 words given.';
    exit 1;
}
