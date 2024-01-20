#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use Math::Prime::Util 'divisors';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

I...
    list of integers

EOS


### Input and Output

say snss(@ARGV);


### Implementation

sub snss {
	sum pdl(@_)->(indx(divisors @_) - 1) ** 2
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is snss(1, 2, 3, 4), 21, 'example 1';
        is snss(2, 7, 1, 19, 18, 3), 63, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is snss(-1, -2), 5, 'negative values';
	}

    done_testing;
    exit;
}
