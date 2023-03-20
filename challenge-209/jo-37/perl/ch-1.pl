#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [BITS]

-examples
    run the examples from the challenge
 
-tests
    run some tests

BITS
    test if BITS form a "special bit sequence"

EOS


### Input and Output

say 0 + bit_sequence(shift);


### Implementation

sub bit_sequence {
	shift =~ /^(11|10|0)*0$/;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  bit_sequence('100'),  'example 1';
        ok !bit_sequence('1110'), 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
