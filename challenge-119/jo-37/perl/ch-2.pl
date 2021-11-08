#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Cartesian::Product;
use experimental qw(signatures postderef);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N ...
    Find the N-th element of the "CY sequence"

EOS


### Input and Output

say cy($_) for @ARGV;


### Implementation

# Find the n-th element of the CY sequence.
sub cy ($n) {
    # CY sequence known so far.
    state @cy;
    # Current number of digits.
    state $digits;

    # Augment the calculated CY sequence by blocks having an increasing
    # number of digits if the requested element isn't in the list yet.
    local $" = '';
    push @cy,
        cartesian {"@_" !~ /11/} ([1 .. 3]) x ++$digits
        while $n > @cy;

    # Join the digits of the n-th element.
    "$cy[$n - 1]->@*";
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is cy(5), 13, 'example 1';
        is cy(10), 32, 'example 2';
        is cy(60), 2223, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is cy(11), 33, 'last 2-digit element';
        is cy(12), 121, 'first 3-digit element';
	}

    done_testing;
    exit;
}
