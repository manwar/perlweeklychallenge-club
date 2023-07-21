#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of non-negative numbers

EOS


### Input and Output

say zero_array(@ARGV);


### Implementation

# To turn all elements to zero following the given rules, we need as
# many steps as there are distinct non-zero elements in the list.
sub zero_array {
    (\my %v)->@{@_} = ();
    scalar grep $_, keys %v;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is zero_array(1, 5, 0, 3, 5), 3, 'example 1';
        is zero_array(0), 0, 'example 2';
        is zero_array(2, 1, 4, 0, 3), 4, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is zero_array(1, 2, 1, 2), 2, 'no zero';
	}

    done_testing;
    exit;
}
