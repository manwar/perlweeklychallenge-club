#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util qw(reduce max);
use experimental 'signatures';

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

say strong_password(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/09/22/ch-287.html#task-1


sub strong_password ($str) {
    max +(length($str) < 6 ? 6 - length($str) : 0),
         (3 - grep eval "\$str =~ tr/$_//", qw(a-z A-Z 0-9)),
         (reduce {$a + int length($b) / 3} 0, $str =~ /((.)\2{2,})/g);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is strong_password("a"), 5, "example 1";
        is strong_password("aB2"), 3, "example 2";
        is strong_password("Paasw0rd"), 0, "example 3";
        is strong_password("Paaasw0rd"), 1, "example 4";
        is strong_password("aaaaaa"), 2, "example 5";
    }

    SKIP: {
        skip "tests" unless $tests;

        is strong_password("aaaaaaaa"), 2, "sequence and classes";
	}

    done_testing;
    exit;
}
