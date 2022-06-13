#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub is_prime ($number) {
    # Return true or false if the number is a prime
    if ( $number < 2 ) {
        return;
    }

    foreach my $i ( 2 .. int( sqrt($number) ) ) {
        if ( $number % $i == 0 ) {
            return;
        }
    }

    # It's a prime
    return 1;
}

sub numerical { $a <=> $b }

sub get_bril_nums ($l) {
    # Get all primes of length l
    my @primes = ();
    foreach my $i ( 10**( $l - 1 ) .. 10**$l ) {
        if ( is_prime($i) ) {
            push @primes, $i;
        }
    }

    # Calculate all brilliant numbers
    my @bril_nums = ();
    while ( my ( $i, $v1 ) = each @primes ) {
        foreach my $v2 ( @primes[ $i .. $#primes ] ) {
            say "$i $v1 $v2";
            push @bril_nums, $v1 * $v2;
        }
    }

    # Return the sorted list
    return sort numerical @bril_nums;
}

sub main() {
    my $l         = 1;
    my @bril_nums = ();

    # Keep increasing the length of primes until we have at least twenty
    #  solutions
    while ( scalar(@bril_nums) < 20 ) {
        push @bril_nums, get_bril_nums($l);
        $l++;
    }

    # Print the first 20 numbers
    say join ', ', @bril_nums[ 0 .. 19 ];
}

main();
