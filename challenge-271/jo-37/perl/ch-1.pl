#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [M]

-examples
    run the examples from the challenge
 
-tests
    run some tests

M
    a matrix as accepted by the PDL constructor, e.g. '1, 0; 0, 1'

EOS


### Input and Output

say maximum_ones(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/05/31/ch-271.html#task-1


sub maximum_ones {
    1 + maximum_ind sumover pdl @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is maximum_ones([[0, 1], [1, 0]]), 1, 'example 1';
        is maximum_ones([[0, 0, 0], [1, 0, 1]]), 2, 'example 2';
        is maximum_ones([[0, 0], [1, 1], [0, 0]]), 2, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
