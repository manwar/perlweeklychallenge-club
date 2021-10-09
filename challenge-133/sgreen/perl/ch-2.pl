#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util 'sum';

sub _digit_sum {
    # Given a string of numbers, calculate the sum of the digits
    my $string = shift;
    return sum split //, $string;
}

sub _prime_factors_sum {
    my $number  = shift;
    my %factors = ();
    my $counter = 2;

    # Get the primes that make up this number
    while ( $number != 1 ) {
        if ( $number % $counter == 0 ) {
            $factors{$counter}++;
            $number /= $counter;
        }
        else {
            $counter++;
        }
    }

    # A prime is not a composite number, and therefore cannot be a
    #  Smiths number. Returning -1 ensures the eqaulity is false
    return -1 if scalar( keys(%factors) ) == 1 and ( values(%factors) )[0] == 1;

    # Return the sum of they sum of digits in the prime multiplied by the power
    # For example 265 = 5¹ * 53¹. The equation is 5 * 1 + (5 + 3) * 1
    return sum( map { _digit_sum($_) * $factors{$_} } keys %factors );
}

sub main {
    my @smiths = ();

    my $number = 1;
    while ( ++$number ) {
        # Add to the array if this is a Smiths number
        push @smiths, $number if _digit_sum($number) == _prime_factors_sum($number);
        last if @smiths == 10;
    }

    say join ', ', @smiths;
}

main();
