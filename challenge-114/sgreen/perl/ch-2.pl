#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $number      = shift;
    my $target_bits = ( sprintf( '%b', $number ) =~ tr/1/1/ );

    # Sanity check
    die "You must specify a number\n" unless defined $number;
    die "The number must be a positive integer\n" unless $number =~ /^[1-9][0-9]*$/;

    while ( ++$number ) {
        my $set_bits = ( sprintf( '%b', $number ) =~ tr/1/1/ );
        if ( $target_bits == $set_bits ) {
            # We have the solution
            say $number;
            return;
        }
    }
}

main(@ARGV);
