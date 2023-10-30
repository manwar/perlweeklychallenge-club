#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

say "(@{running_sum(@ARGV)})";


### Implementation

sub running_sum {
    pdl(@_)->cumusumover->unpdl;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is running_sum(1, 2, 3, 4, 5), [1, 3, 6, 10, 15], 'example 1';
        is running_sum(1, 1, 1, 1, 1), [1, 2, 3, 4, 5], 'example 2';
        is running_sum(0, -1, 1, 2), [0, -1, 0, 2], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
