#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use PDL::Char;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

STR
    an ASCII string

EOS


### Input and Output

say score(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/06/07/ch-272.html#task-2


sub score {
	my $s = PDL::Char->new(shift);
    sum abs long($s(0:-2)) - long($s(1:-1));
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is score("hello"), 13, "example 1";
        is score("perl"), 30, "example 2";
        is score("raku"), 37, "example 3";
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
