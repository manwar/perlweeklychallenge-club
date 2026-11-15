#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util "max";

sub find_max_freq ($str) {
    # Find the most frequently used letter
    my %freq = ();
    $freq{$_}++ foreach ( split //, $str );
    return max( values(%freq) );
}

sub main ( $input_string, $k ) {
    my $string_length = length($input_string);

    # Generate all possible substrings, starting with longest first
    for ( my $length = $string_length ; $length > 0 ; $length-- ) {
        foreach my $start ( 0 .. $string_length - $length ) {
            my $substr = substr( $input_string, $start, $length );

            # Find the frequency of the most used character
            my $max_freq = find_max_freq($substr);

            # If the highest frequency + letter we can change (k) is higher
            #  than the length, we have the solution
            if ( $max_freq + $k >= $length ) {
                say $length;
                return;
            }
        }
    }

    say 0;
}

main(@ARGV);
