#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [n1...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

n1...
    list of numbers

EOS


### Input and Output

say max_ind(@ARGV);


### Implementation

# Without much ado:
sub max_ind {
	pdl(@_)->maximum_ind;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is max_ind(5, 2, 9, 1, 7, 6), 2, 'example 1';
        is max_ind(4, 2, 3, 1, 5, 0), 4, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is max_ind(-1, -2, -1, -3.1, -0.9, -1e10), 4, 'negative and fp';
	}

    done_testing;
    exit;
}
