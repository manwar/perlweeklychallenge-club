#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util 'max';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

S...
    list of strings

EOS


### Input and Output

say max_val(@ARGV);


### Implementation

sub max_val {
	max map /^\d+$/ ? 0 + $_ : length, @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is max_val("perl", "2", "000", "python", "r4ku"), 6, 'example 1';
        is max_val("001", "1", "000", "0001"), 1, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
