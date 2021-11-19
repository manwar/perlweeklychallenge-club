#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util qw(reduce);
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N1 N2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N1 N2...
    Check if the numbers N1 N2... are sorted.

EOS


### Input and Output

say 0 + jortsort(\@ARGV);


### Implementation

# Check if the given array is sorted.  Using "die" as a fast-track exit
# from "reduce" at the first number pair that is found to be out of
# order.
sub jortsort ($arr) {
    eval {reduce {die if $b < $a; $b} @$arr};
    !$@;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is jortsort([1,2,3,4,5]), T(), 'example 1';
        is jortsort([1,3,2,4,5]), F(), 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is jortsort([]), T(), 'empty lists are sorted';
        is jortsort([1]), T(), 'singletons are sorted';
	}

    done_testing;
    exit;
}
