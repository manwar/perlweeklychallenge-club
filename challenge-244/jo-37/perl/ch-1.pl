#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Rank 'rank';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

say "(@{[count_smaller(@ARGV)]})";


### Implementation

sub count_smaller {
	map tr/=//dr - 1, rank @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [count_smaller(8, 1, 2, 2, 3)], [4, 0, 1, 1, 3], 'example 1';
        is [count_smaller(6, 5, 4, 8)], [2, 1, 0, 3], 'example 2';
        is [count_smaller(2, 2, 2)], [0, 0, 0], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
