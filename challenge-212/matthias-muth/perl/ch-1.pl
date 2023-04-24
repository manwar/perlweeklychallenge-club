#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 212 Task 1: Jumping Letters
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;

sub jumping_letters {
    my ( $word, $jump ) = @_;

    my $i = 0;
    $word =~ s{([A-Z])|[a-z]}{
        my $base = ord( $1 ? 'A' : 'a' );
        chr( $base + ( ( ord( $& ) - $base ) + $jump->[$i++] ) % 26 );
    }eg;
    return $word;
}


use Test::More;
use Data::Dump qw( pp );

do {
    is jumping_letters( @{$_->{INPUT}} ), $_->{EXPECTED},
        "jumping_letters( " . pp( $_->{INPUT} ) . " ) == " . pp( $_->{EXPECTED} );
} for (
    { INPUT => [ "Perl", [ 2,22,19,9 ] ], EXPECTED => "Raku" },
    { INPUT => [ "Raku", [ 24,4,7,17 ] ], EXPECTED => "Perl" },
);

done_testing;
