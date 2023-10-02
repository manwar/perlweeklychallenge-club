#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;

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

say uniq_sum(@ARGV);


### Implementation

sub uniq_sum {
	my ($freq, $val) = long(\@_)->qsort->rle;
    $val->where($freq == 1)->sum;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is uniq_sum(2, 1, 3, 2), 4, 'example 1';
        is uniq_sum(1, 1, 1, 1), 0, 'example 2';
        is uniq_sum(2, 1, 3, 4), 10, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
