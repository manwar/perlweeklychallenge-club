#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Regexp::Common 'net';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    "defang" string

EOS


### Input and Output

say defang(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/06/07/ch-272.html#task-1


sub defang {
    return /^$RE{net}{IPv4}$/ &&

    s([.])([.])gr

    for shift;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is defang("1.1.1.1"), "1[.]1[.]1[.]1", "example 1";
        is defang("255.101.1.0"), "255[.]101[.]1[.]0", "example 2";
    }

    SKIP: {
        skip "tests" unless $tests;

        is defang("256.0.0.1"), F(), 'invalid address';
        is defang("1.0.0.256"), F(), 'invalid address';
	}

    done_testing;
    exit;
}
