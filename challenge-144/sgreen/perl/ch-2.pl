#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use POSIX 'ceil';
use List::Util 'any';

sub main {
    my ( $m, $n ) = @_;

    if ( $m < 1 ) {
        raise ValueError('The first number must be a positive integer');
    }
    if ( $n < 1 ) {
        raise ValueError('The second number must be a positive integer');
    }

    # We know the first three values in the sequence are the two numbers and the sum
    my @seq           = ( $m, $n, $m + $n );
    my $current_value = $seq[-1] + 1;

    while ( @seq < 10 ) {
        my $sums = 0;
        foreach my $i ( $m .. ceil( $current_value / 2 ) - 1 ) {
            my $j = $current_value - $i;
            if ( any { $i == $_ } @seq and any { $j == $_ } @seq ) {
                $sums++;
            }
        }

        if ( $sums == 1 ) {
            push @seq, $current_value;
        }

        $current_value++;
    }

    say join ', ', @seq;
}

main(@ARGV);
