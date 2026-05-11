#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    # Calculate the frequency of each letter
    my %freq = ();
    $freq{$_}++ foreach ( split //, $input_string );
    my $largest = -1;

    # Loop through all the letters found
    while ( my ( $letter, $count ) = each %freq ) {
        if ( $count > 1 ) {
            # If the letter occurs multiple times, calculate the span and
            #  update the largest value if required.
            my $substr = rindex( $input_string, $letter ) -
              index( $input_string, $letter ) - 1;
            $largest = $substr if ( $substr > $largest );
        }
    }

    say $largest;
}

main(@ARGV);
