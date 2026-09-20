#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Prime Sum
# Find the minimum number of prime numbers required whose summation gives $n.
# Note: 1 is not considered prime.

sub is_prime ($n) {
    return 0 if $n < 2;
    return 1 if $n == 2 || $n == 3;
    return 0 if $n % 2 == 0 || $n % 3 == 0;

    my $i = 5;
    while ( $i * $i <= $n ) {
        return 0 if $n % $i == 0 || $n % ( $i + 2 ) == 0;
        $i += 6;
    }
    return 1;
}

sub get_nr_primes ($n) {
    return 0 if $n < 2;

    # 1 prime if $n itself is prime
    return 1 if is_prime($n);

    # If $n is even, by Goldbach's conjecture (for all even n > 2), it is the sum of 2 primes.
    return 2 if $n % 2 == 0;

    # If $n is odd:
    # If $n - 2 is prime, then $n = 2 + ($n - 2), so 2 primes.
    return 2 if is_prime( $n - 2 );

    # Otherwise, by Goldbach's weak conjecture, every odd n > 5 is the sum of 3 primes:
    # $n = 3 + ($n - 3), where $n - 3 is even and expressible as sum of 2 primes.
    return 3;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( get_nr_primes(2),  1, 'Example: 2 is prime (1 prime)' );
    is( get_nr_primes(9),  2, 'Example: 9 = 2 + 7 (2 primes)' );
    is( get_nr_primes(10), 2, 'Example: 10 = 3 + 7 or 5 + 5 (2 primes)' );
    is( get_nr_primes(12), 2, 'Even number 12 = 5 + 7 (2 primes)' );
    is( get_nr_primes(27), 3, 'Odd number 27 = 3 + 24 = 3 + 5 + 19 (3 primes)' );

    done_testing();
}
else {
    say get_nr_primes( $ARGV[0] );
}
