#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(all any min);

sub is_achilles_number ($num) {
    # Get the prime factors of the number
    my %factors = ();

    my $i = 2;
    while ( $num > 1 ) {
        if ( $num % $i == 0 ) {
            $num /= $i;
            if ( exists( $factors{$i} ) ) {
                $factors{$i}++;
            }
            else {
                $factors{$i} = 1;
            }
        }
        else {
            $i++;
        }
    }

    # If there is only one prime factor, it is not an achilles number
    if ( scalar( keys %factors ) == 1 ) {
        return;
    }

    # Get a list of unique powers
    my @powers = values(%factors);

    # It's also not an achilles number if any of the powers were 1, or the
    #  powers are all the same (a perfect sqaure)
    if ( $#powers == 0 or any { $_ == 1 } @powers ) {
        return;
    }

    # Finally, the greatest common divisor of these numbers has to be one
    foreach my $i ( 2 .. min(@powers) ) {
        if ( all { $_ % $i == 0 } @powers ) {
            return;
        }
    }

    return 1;
}

sub main() {
    my @solutions = ();
    my $num       = 2;

    # Get the first 20 achilles numbers
    while ( $#solutions < 19 ) {
        if ( is_achilles_number($num) ) {
            push @solutions, $num;
        }
        $num++;
    }

    # Print the list
    say join ', ', @solutions;
}

main();