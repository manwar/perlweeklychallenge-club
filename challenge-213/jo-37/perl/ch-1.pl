#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

main: {
    local $" = ',';
    say "(@{[fun_sort(@ARGV)]})";
}


### Implementation

sub fun_sort {
    sort {$a % 2 <=> $b % 2 || $a <=> $b} @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [fun_sort(1,2,3,4,5,6)], [2,4,6,1,3,5], 'example 1';
        is [fun_sort(1,2)], [2, 1], 'example 2';
        is [fun_sort(1)], [1], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
