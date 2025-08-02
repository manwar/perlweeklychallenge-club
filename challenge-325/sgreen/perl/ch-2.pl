#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@prices) {
    my @solution = ();
    foreach my $i ( 0 .. $#prices ) {
        my $discount = 0;
        foreach my $j ( $i + 1 .. $#prices ) {
            if ( $prices[$j] <= $prices[$i] ) {
                $discount = $prices[$j];
                last;
            }
        }
        push @solution, $prices[$i] - $discount;
    }

    say '(' . join( ', ', @solution ) . ')';
}

main(@ARGV);
