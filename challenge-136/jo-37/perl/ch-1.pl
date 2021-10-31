#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(gcd logint);
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [M N ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

M N ...
    Check if M, N, ... are "friendly".

EOS


### Input and Output

say 0 + !!friendly(@ARGV);


### Implementation

# I couldn't find any reference to "two friendly".  Maybe Mohammad
# created this concept?
# There's no need to restrict the definition to two numbers.

sub friendly (@n) {
    my ($gcd, $pot) = gcd @n;
    # Calculate the integer binary logarithm of the GCD together with
    # its (back-)exponentiation and return "false" for a zero logarithm.
    logint $gcd, 2, \$pot or return;

    # Check if the GCD is a full power of two.
    $gcd == $pot;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok friendly(8, 24), 'example 1';
        ok !friendly(26, 39), 'example 2';
        ok friendly(4, 10), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok !friendly(2, 3), 'no common divisor';
        ok friendly(12, 20, 28), 'three friendly';
        ok !friendly(12, 36, 60), 'GCD not a power of two';
	}

    done_testing;
    exit;
}
