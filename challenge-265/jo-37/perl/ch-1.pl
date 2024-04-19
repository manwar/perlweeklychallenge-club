#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util 'reduce';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of integers

EOS


### Input and Output

say appearance33(@ARGV);


### Implementation

sub appearance33 {
    my %count;
	reduce {
        ++$count{$b} * 100 / @_ >= 33 && $b < ($a // 'inf') ? $b : $a;
    } undef, @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is appearance33(1,2,3,3,3,3,4,2), 3, 'example 1';
        is appearance33(1, 1), 1, 'example 2';
        is appearance33(1, 2, 3), 1, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
        is appearance33((2, 3) x 33, (1) x 34), 1, 'exactly 33%';
        is appearance33((1, 2, 3) x 32, (4) x 4), U(), 'nothing found';
	}

    done_testing;
    exit;
}
