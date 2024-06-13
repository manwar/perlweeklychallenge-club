#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    a string

EOS


### Input and Output

say +(qw(true false))[!b_after_a(shift)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/06/14/ch-273.html#task-2


sub b_after_a {
	shift =~ /^[^b]*+b[^a]*+$/;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  b_after_a("aabb"), 'example 1';
        ok !b_after_a("abab"), 'example 2';
        ok !b_after_a("aaa"),  'example 3';
        ok  b_after_a("bbb"),  'example 4';

    }

    SKIP: {
        skip "tests" unless $tests;

        ok b_after_a("b"), 'single b';
	}

    done_testing;
    exit;
}
