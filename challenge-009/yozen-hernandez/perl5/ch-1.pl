#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

my $n = 5;

#my $n = <STDIN>;
#chomp $n;

# Start with the root of the first $n-digit square
# or closest integer
my $root=  int( sqrt( 10**( $n - 1 ) ) );

while ( 1 ) {

    # Use positive lookahead to get rid of duplicate digits
    ( my $dedup = $root**2 ) =~ s/(.)(?=.*?\1)//g;
    last if ( length($dedup) >= $n );
    $root++;
}

say $root**2;
