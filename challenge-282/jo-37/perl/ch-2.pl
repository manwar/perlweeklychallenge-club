#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use utf8;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    a string

EOS


### Input and Output

say changing_keys(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/08/16/ch-282.html#task-2


sub changing_keys {
    (() = lc(shift) =~ /(.)\1*/g) - 1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is changing_keys('pPeERrLl'), 3, 'example 1';
        is changing_keys('rRr'), 0, 'example 2';
        is changing_keys('GoO'), 1, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is changing_keys('ßss'), 1, 'multiple lower';
        is changing_keys('ßSS'), 1, 'multiple upper';
        is changing_keys('Σς'), 1, 'different keys';
        is changing_keys('σς'), 1, 'different keys';
        is changing_keys('Σσ'), 0, 'same key';
	}

    done_testing;
    exit;
}
