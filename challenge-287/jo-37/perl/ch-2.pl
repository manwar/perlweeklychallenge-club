#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Regexp::Common;

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

say +(qw(true false))[!valid_number(shift)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/09/22/ch-287.html#task-2


sub valid_number {
	shift =~ /^$RE{num}{real}\z/;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  valid_number("1"),       "example 1";
        ok !valid_number("a"),       "example 2";
        ok !valid_number("."),       "example 3";
        ok !valid_number("1.2e4.2"), "example 4";
        ok  valid_number("-1."),     "example 5";
        ok  valid_number("+1E-8"),   "example 6";
        ok  valid_number(".44"),     "example 7";
    }

    SKIP: {
        skip "tests" unless $tests;

        ok !valid_number("42\n"), "newline not allowed";
	}

    done_testing;
    exit;
}
