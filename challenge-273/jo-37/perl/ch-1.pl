#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [C STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

C
    a single character (or string)

STR
    a string

EOS


### Input and Output

say pct_sub(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/06/14/ch-273.html#task-1


sub pct_sub ($sub, $str) {
    return int .5 + 100 * (() = /\Q$sub/g) * length($sub) / length for $str;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is pct_sub("e", "perl"),      25, 'example 1';
        is pct_sub("a", "java"),      50, 'example 2';
        is pct_sub("m", "python"),     0, 'example 3';
        is pct_sub("a", "ada"),       67, 'example 4';
        is pct_sub("l", "ballerina"), 22, 'example 5';
        is pct_sub("k", "analitik"),  13, 'example 6';
    }

    SKIP: {
        skip "tests" unless $tests;

        is pct_sub("12", "123"), 67, 'not a single character';
        is pct_sub('.$', '.$--.$'), 67, 'meta characters';
	}

    done_testing;
    exit;
}
