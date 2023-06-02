#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

say "@{[sorted_squares(@ARGV)]}";


### Implementation

sub sorted_squares {
	sort {$a <=> $b} map $_ * $_, @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [sorted_squares(-2, -1, 0, 3, 4)],
        [0, 1, 4, 9, 16], 'example 1';

        is [sorted_squares(5, -4, -1, 3, 6)],
        [1, 9, 16, 25, 36], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
