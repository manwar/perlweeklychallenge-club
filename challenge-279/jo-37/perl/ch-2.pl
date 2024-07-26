#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

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

say +(qw(false true))[split_string(shift)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/07/26/ch-279.html#task-2


sub split_string {
	local $_ = shift;

    !(tr/aeiouAEIOU// % 2);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok !split_string("perl"), 'example 1';
        ok  split_string("book"), 'example 2';
        ok  split_string("good morning"), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
