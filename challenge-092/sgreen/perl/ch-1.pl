#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _is_isomorphic {
    my ( $first, $second ) = @_;
    # If the strings aren't the same length, they can't be isomorphic
    return if length($first) != length($second);

    my %table = ();
    for my $c ( 0 .. length($first) - 1 ) {
        my $c1 = substr( $first,  $c, 1 );
        my $c2 = substr( $second, $c, 1 );

        if ( my $x = $table{$c1} ) {
         # We've seen this letter before, return if the character isn't the same
            return 0 if $x ne $c2;
        }
        else {
            # Add this character to the hash in case we see it again
            $table{$c1} = $c2;
        }
    }

    return 1;
}

sub main {
    my ( $A, $B ) = @_;
    say _is_isomorphic( $A, $B ) && _is_isomorphic( $B, $A ) ? 1 : 0;
}

main(@ARGV);
