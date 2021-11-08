#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $number = shift;

    die "The value is not a number >= 10\n" unless $number =~ /^[1-9][0-9]+(?:\.[0-9]*)?$/;

    # Try for different lengths of first numbers
  L: for my $length ( 1 .. length($number) ) {

        # Seed the sequence with the number of this length
        my @sequence = ( substr( $number, 0, $length ) );

        # Skip if the last character is the period. This prevents '10.11'
        #  as a solution
        next if $sequence[-1] =~ /\.$/;

        # Keep adding the sequence until we have enough numbers
        while ( length( join( '', @sequence ) ) < length($number) ) {
            push @sequence, $sequence[-1] + 1;

            my $seq = join '', @sequence;

            # Handle edge case where there is a trailing .0 in there
            $sequence[-1] .= $1 if $number =~ /^$seq(\.0+)/;

            # ... but solutions with two dots aren't numbers
            next L if $seq =~ /\..*\./;
        }

        if ( join( '', @sequence ) == $number ) {
            say join ',', @sequence;
            return;
        }
    }

    say $number;

}

main(@ARGV);
