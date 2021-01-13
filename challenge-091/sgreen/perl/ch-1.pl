#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $string = shift;
    my @result = ();

    # Sanity check
    die "You must enter a positive integer\n" unless $string;
    die "The value doesn't appear to be a positive integer\n"
      unless $string =~ /^[1-9][0-9]*$/;

    while ( length($string) ) {
        # Get the first remaining character(s), and remove it from the string
        my $char = substr( $string, 0, 1 );
        ( my $match, $string ) = ( $string =~ /^($char+)(.*)$/ );

        # Add the length and the number to the array
        push @result, length($match), $char;
    }

    # Output the result
    say join '', @result;
}

main(@ARGV);
