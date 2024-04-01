#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util qw(max reduce);

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

say mpn(@ARGV);


### Implementation

sub mpn {
	max +(reduce {$a->[1 + ($b <=> 0)]++; $a} [0,0,0], @_)->@[0,2];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is mpn(-3, 1, 2, -1, 3, -2, 4), 4, 'example 1';
        is mpn(-1, -2, -3, 1), 3, 'example 2';
        is mpn(1,2), 2, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
