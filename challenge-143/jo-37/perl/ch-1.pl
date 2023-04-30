#!/usr/bin/perl -Ts

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [EXPR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

EXPR
    arithmetic expression made of digits, whitespace, '+', '-', '*' and
    parentheses

EOS


### Input and Output

say calculator(shift);


### Implementation

sub calculator ($s) {
    # Laundering the input string:
	$s =~ /^([-+*\d\s()]*)$/ or return "expression invalid: $s";
    my $result = eval $1;
    $@ ? $@ : $result;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is calculator('10 + 20 - 5'), 25, 'example 1';
        is calculator('(10 + 20 - 5) * 2'), 50, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
