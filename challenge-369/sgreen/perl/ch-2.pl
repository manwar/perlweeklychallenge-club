#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ( $input_string, $size, $filler ) {
    # Split the input string into $size long parts
    my @result = ();
    for ( my $i = 0 ; $i < length($input_string) ; $i += $size ) {
        push @result, substr( $input_string, $i, $size );
    }

    # Use the filler to pad out the last item in the array
    $result[-1] .= $filler x ( $size - length( $result[-1] ) );

    say '("' . join( '", "', @result ) . '")';
}

main(@ARGV);
