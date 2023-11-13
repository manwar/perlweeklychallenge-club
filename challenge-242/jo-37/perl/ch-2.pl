#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [M]

-examples
    run the examples from the challenge
 
-tests
    run some tests

M
    matrix in a representation as accepted by the PDL string
    constructor, e.g. '1 1 0; 0 1 1; 0 0 1'

EOS


### Input and Output

say flip_matrix(@ARGV);


### Implementation

# Reverse rows and invert values.
sub flip_matrix {
	!long(@_)->(-1:0);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is flip_matrix([1, 1, 0], [0, 1, 1], [0, 0, 1])->unpdl,
            [[1, 0, 0], [0, 0, 1], [0, 1, 1]], 'intro';
        is flip_matrix([1, 1, 0], [1, 0, 1], [0, 0, 0])->unpdl,
            [[1, 0, 0], [0, 1, 0], [1, 1, 1]], 'example 1'; 
        is flip_matrix([1, 1, 0, 0], [1, 0, 0, 1],
            [0, 1, 1, 1], [1, 0, 1, 0])->unpdl,
            [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]],
            'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is flip_matrix([0, 0, 1], [1, 1, 0])->unpdl,
            [[0, 1, 1], [1, 0, 0]], 'non quadratic matrix';
	}

    done_testing;
    exit;
}
