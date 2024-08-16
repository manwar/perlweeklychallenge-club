#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    a number (or string)

EOS


### Input and Output

say good_integer(shift) // -1;


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/08/16/ch-282.html#task-1


sub good_integer {
    (shift =~ /((.)(?<!(?=\2)..)\2{2})(?!\2)/)[0];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is good_integer(12344456), 444, 'example 1';
        is good_integer(1233334), U(), 'example 2';
        is good_integer(10020003), '000', 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is good_integer(1112), 111, 'at start';
        is good_integer(1222), 222, 'at end';
        is good_integer(111), 111, 'completely good';
        is good_integer('abbbaa'), 'bbb', 'not a number';
        is good_integer(122234445), 222, 'pick the first match';
	}

    done_testing;
    exit;
}
