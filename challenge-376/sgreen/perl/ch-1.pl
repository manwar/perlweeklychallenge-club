#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub is_black($cell) {
    # Check the cell is valid
    if ( $cell !~ /^[a-h][1-8]$/ ) {
        die "Cell '$cell' is not valid!\n";
    }

    # Return 1 if it is black or 0 if it is white
    return ( index( "aceg", substr( $cell, 0, 1 ) ) == -1 ? 0 : 1 )
      ^ ( substr( $cell, 1, 1 ) % 2 );
}

sub main ( $c1, $c2 ) {
    say is_black($c1) == is_black($c2) ? 'true' : 'false';
}

main(@ARGV);
