#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ( $num, $k ) {
    my $count = 0;

    # Compute all substrings of length 'k'
    foreach my $start ( 0 .. length($num) - $k ) {
        # If it is evenly divisible, increment the count value.
        if ( $num % substr( $num, $start, $k ) == 0 ) {
            ++$count;
        }
    }

    say $count;
}

main(@ARGV);
