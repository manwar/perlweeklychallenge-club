#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [M N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

M
    number to be processed

N
    bit position

EOS


### Input and Output

say invert_nth_bit($ARGV[0], $ARGV[1]);


### Implementation

sub invert_nth_bit ($m, $n) {
	$m ^ 1 << ($n - 1);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is invert_nth_bit(12, 3), 8, 'example 1';
        is invert_nth_bit(18, 4), 26, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is invert_nth_bit(0, 32), 2 ** 31, 'not limited to N <= 8';
        is invert_nth_bit(2 ** 31, 32), 0, 'not limited to M < 256';
	}

    done_testing;
    exit;
}
