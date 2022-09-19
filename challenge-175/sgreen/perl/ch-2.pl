#!/usr/bin/env perl

use strict;
use warnings;
use feature (qw(say state));
use experimental 'signatures';
use List::Util 'none';

our @primes = ();

sub is_prime ($number) {
    # Return true or false if the number is a prime
    if ( $number < 2 ) {
        return;
    }

    foreach my $i (@primes) {
        if ( $number % $i == 0 ) {
            return;
        }
    }

    # It's a prime
    return 1;
}

sub get_factors ($num) {
    # Get the prime factors that make up the numbers
    state %factors = ();

    if ( not exists $factors{$num} ) {
        $factors{$num} = [];

        foreach my $p (@primes) {
            push @{ $factors{$num} }, $p if $num % $p == 0;
        }
    }

    return $factors{$num};
}

sub get_totients ($num) {
    state %totients = ();
    # Count the number of values between 1 and num-1 that has the gcd of 1

    # If we've calculated this before, return the result
    if ( not exists $totients{$num} ) {
        my $factors = get_factors($num);
        my %primes  = map { $_, 1 } @$factors;

        my $count = 0;
        foreach my $n ( 1 .. $num - 1 ) {
            # Count this number if it has no common factors (other than 1)
            $factors = get_factors($n);
            ++$count if none { $primes{$_} } @$factors;
        }

        # Store the result when we need it again
        $totients{$num} = $count;
    }

    return $totients{$num};
}

sub is_ptn ($num) {
    # Return whether this number is a perfect totient number

    # Keep a count of the total
    my $totals = 0;

    # Loop until we get to one
    my $n = $num;
    while ( $n > 1 ) {
        my $totient = get_totients($n);
        $totals += $totient;

        if ( $totals > $num ) {
            # Short circuit exit if we know it will be False
            return;
        }

        $n = $totient;
    }

    return $totals == $num ? 1 : 0;
}

sub main {
    my @solutions = ();
    my $number    = 0;

    # Loop until we have 20 solutions
    while ( scalar(@solutions) < 20 ) {
        $number++;

        if ( is_prime($number) ) {
            push @primes, $number;
        }

        if ( is_ptn($number) ) {
            push @solutions, $number;
        }
    }

    say join ', ', @solutions;
}

main();