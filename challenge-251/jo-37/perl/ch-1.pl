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
    list of non-negative integers

EOS


### Input and Output

say concat_val(@ARGV);


### Implementation

sub concat_val {
    my $val = 0;
	while (@_) {
        $val += shift() . (pop() // '');
    }
    $val;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is concat_val(6, 12, 25, 1), 1286, 'example 1';
        is concat_val(10, 7, 31, 5, 2, 2), 489, 'example 2';
        is concat_val(1, 2, 10), 112, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
