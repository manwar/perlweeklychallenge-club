#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util 'sum';

sub armstrong_sum( $num, $base ) {
    # Convert the number into digits in the specified base
    my @digits = ();
    while (1) {
        my $i = int( $num / $base );
        my $j = $num % $base;
        unshift @digits, $j;

        if ( $i == 0 ) {
            last;
        }

        $num = $i;
    }

    # Compute the armstrong sum by calculating the sum of each digit to the
    #  power of the number of digits
    my $count = scalar(@digits);
    return sum( map { $_**$count } @digits );
}

sub main ( $base, $limit ) {
    my @results = ();

    for my $i ( 0 .. $limit - 1 ) {
        if ( armstrong_sum( $i, $base ) == $i ) {
            push @results, $i;
        }
    }

    say "(" . join( ", ", @results ) . ")";
}

main(@ARGV);
