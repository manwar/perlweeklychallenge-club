#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use Math::Prime::Util 'factor';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of positive integers

EOS


### Input and Output

say "(@{prime_order(@ARGV)})";


### Implementation

# This task is very similar to task 2 from week 238.  Following the same
# approach.

sub prime_order {
    long(map [scalar factor $_, $_], @_)->qsortvec->((1))->unpdl;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is prime_order(11, 8, 27, 4), [11, 4, 8, 27], 'example 1';
    }

    SKIP: {
        skip "tests" unless $tests;

        is prime_order(27, 8, 121, 49, 167, 131),
            [131, 167, 49, 121, 8, 27], 'another example';
	}

    done_testing;
    exit;
}
