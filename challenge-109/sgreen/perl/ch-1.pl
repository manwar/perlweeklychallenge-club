#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util 'sum';

sub _divisors {
    my $number   = shift;
    my @divisors = (0);

    for my $i ( 2 .. $number / 2 ) {
        if ( $number % $i == 0 ) {
            # This number is a divisor
            push @divisors, $i;
        }
    }

    # Return the sum of the unique divisors
    return sum(@divisors);
}

sub main {
    my $numbers = shift // 20;
    say join ', ', map { _divisors($_) } ( 1 .. $numbers );
}

main(@ARGV);
