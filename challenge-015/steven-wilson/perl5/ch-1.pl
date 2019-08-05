#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-07-01
# Week: 015
# Challenge: #1
#
# Write a script to generate first 10 strong and weak prime numbers.
#   For example, the nth prime number is represented by p(n).
# p(1) = 2
# p(2) = 3
# p(3) = 5
# p(4) = 7
# p(5) = 11
#   Strong Prime number p(n) when p(n) > [ p(n-1) + p(n+1) ] / 2
#   Weak   Prime number p(n) when p(n) < [ p(n-1) + p(n+1) ] / 2

use strict;
use warnings;
use feature qw / say /;

my $previous_prime = 2;
my $current_prime  = 3;
my $next           = 5;
my @strong_primes;
my @weak_primes;

while ( ( @strong_primes < 10 || @weak_primes < 10 ) ) {
    my $is_prime = is_prime($next);
    if ( $is_prime
        && ( $current_prime > ( ( $previous_prime + $next ) / 2 ) ) )
    {
        push @strong_primes, $current_prime;
    }
    elsif ( $is_prime
        && ( $current_prime < ( ( $previous_prime + $next ) / 2 ) ) )
    {
        push @weak_primes, $current_prime;
    }
    if ($is_prime) {
        ( $previous_prime, $current_prime ) = ( $current_prime, $next );
    }
    $next++;
}

sub is_prime {
    my $number   = shift;
    my $is_prime = 1;
    for ( 2 .. sqrt($number) ) {
        if ( $number % $_ == 0 ) {
            $is_prime = 0;
            last;
        }
    }
    return $is_prime;
}

print "First 10 strong primes: ";
print "@strong_primes\n";
print "First 10 weak primes: ";
print "@weak_primes\n";
