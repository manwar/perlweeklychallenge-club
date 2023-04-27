#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Math::Prime::Util qw(sqrtint is_square);
use List::Gen;  # for testing only
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    check if N is stealthy

EOS


### Input and Output

say 0 + !!is_stealthy(shift);

### Implementation

# If n can be written as p * (p + 1) * q * (q + 1), then it is stealthy,
# because
# n = (p * (q + 1)) * (q * (p + 1)) = (p * q) * ((p + 1) * (q + 1))
#     ===== a =====   ===== b =====   == c ==   ======== d ========
#
# a + b = p * (q + 1) + q * (p + 1) = 2 * p * q + p + q
# c + d = p * q + (p + 1) * (q + 1) = 2 * p * q + p + q + 1
#
# Showing the reverse:  If n can be written as
# n = a * b = c * d
# then at least one of a or b and c or d must have a common factor.  If
# we allow "one" as a factor, the same holds for the other pair.  Thus
# n can be writtes as n = p * q * r * s with at least two different
# factors including "one".
# Then we can arrange
# n = (p * q) * (r * s) = (p * r) * (q * s)
# a = p * q, b = r * s, c = p * r and d = q * s
# The factor sums then must agree to
# p * q + r * s = p * r + q * s + 1
# which can be written as
# (p - s) * (q - r) = 1
# If the product of two integers is one, both factors must be one,
# leading to
# p = s + 1 and q = r + 1
# or
# n = r * (r + 1) * s * (s + 1).
#
# References:
# https://projecteuler.net/problem=757
# https://oeis.org/A072389
#
sub is_stealthy ($n) {
    # n must have two even factors.
    return if $n % 4;
    my $p1;
    # Loop over all factors p * (p + 1) having p**2 * (p + 1)**2 <= n,
    # i.e p <= q.  The number of these factors has the order of the
    # fourth root of n.
    for (1 .. (sqrtint(1 + 4 * sqrtint($n)) - 1) / 2) {
        $p1 = $_ * ($_ + 1);
        # Check if n is divisable by p * (p + 1)
        next if $n % $p1;
        # Check if the complement has the form q * (q + 1)
        return 1 if is_square(4 * $n / $p1 + 1);
    }
    undef;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  is_stealthy(36), 'example 1';
        ok  is_stealthy(12), 'example 2';
        ok !is_stealthy(6),  'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is <4 .. 1e6 by 4>->filter(sub {is_stealthy($_)})->apply->size,
            2851, 'From Project Euler, Problem 757';
        ok is_stealthy(10000**2 * 10001**2), '10002000100000000';
	}

    done_testing;
    exit;
}
