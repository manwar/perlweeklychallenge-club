#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [X Y]

-examples
    run the examples from the challenge
 
-tests
    run some tests

X Y
    two vectors in any representation as accepted by the PDL
    constructor, e.g.  x1,x2,...

EOS


### Input and Output

say dot_product(@ARGV);


### Implementation

sub dot_product ($x, $y) {
    (pdl($x) x pdl($y)->dummy(0))->sclr;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is dot_product([1, 2, 3], [4, 5, 6]), 32, 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
