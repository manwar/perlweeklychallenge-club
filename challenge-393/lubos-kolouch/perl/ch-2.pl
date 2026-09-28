#!/usr/bin/env perl
use v5.38;
use warnings;
use List::Util qw(sum0);
use Test::More;

# Task 2: Prime Step
# Find the absolute difference of the sum of the ASCII values of the characters
# in the string to the nearest prime number.

sub is_prime ($n) {
    return 0 if $n < 2;
    return 1 if $n == 2 || $n == 3;
    return 0 if $n % 2 == 0 || $n % 3 == 0;

    my $d = 5;
    while ( $d * $d <= $n ) {
        return 0 if $n % $d == 0 || $n % ( $d + 2 ) == 0;
        $d += 6;
    }
    return 1;
}

sub nearest_prime_diff ($str) {
    my $sum = sum0 map { ord($_) } split //, $str;

    return 0 if is_prime($sum);

    my $diff = 1;
    while (1) {
        if ( $sum - $diff >= 2 && is_prime( $sum - $diff ) ) {
            return $diff;
        }
        if ( is_prime( $sum + $diff ) ) {
            return $diff;
        }
        $diff++;
    }
}

# TESTS
is( nearest_prime_diff('hello'),     9, 'Example 1: hello' );
is( nearest_prime_diff('football'),  2, 'Example 2: football' );
is( nearest_prime_diff('a'),         0, 'Example 3: a' );
is( nearest_prime_diff('challenge'), 2, 'Example 4: challenge' );
is( nearest_prime_diff('perl'),      2, 'Example 5: perl' );

done_testing;
