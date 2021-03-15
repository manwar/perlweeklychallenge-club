#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _find_string {
    my ( $string, $substring ) = @_;
    my ( $first,  $rest )      = ( $substring =~ /^(.)(.*)$/ );
    my $matches = 0;

    foreach my $i ( 0 .. length($string) ) {
        if ( substr( $string, $i, 1 ) eq $first ) {
            if ( length($rest) ) {
                # Call the function again with the remaining characters
                $matches += _find_string( substr( $string, $i + 1 ), $rest );
            }
            else {
                # We have found a match!
                $matches++;
            }
        }
    }

    return $matches;
}

sub main {
    my ( $string, $substring ) = @_;

    # Sanity check
    die "You must enter a string\n"     unless defined $string;
    die "You must enter a sub-string\n" unless defined $substring;

    say _find_string( $string, $substring );
}

main(@ARGV);

