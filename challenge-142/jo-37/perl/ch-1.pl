#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util 'divisors';
use experimental 'signatures';

our ($tests, $examples, $base);
$base //= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [-base=B] [M N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=B
    Use base B. Default: 10

M N
    count the divisors of M having N as last digit in base B.

EOS


### Input and Output

say num_div_mod(@ARGV, $base);


### Implementation

# Generalizing the task by taking "the last digit" in a given base.
sub num_div_mod ($m, $n, $base=10) {
    scalar grep $_ % $base == $n, divisors $m
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is num_div_mod(24, 2), 2, 'example 1';
        is num_div_mod(30, 5), 2, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is num_div_mod(9, 1, 2), 3, 'odd divisors of 9';
        is num_div_mod(8, 0, 2), 3, 'even divisors of 8';
        is num_div_mod(24, 0, 1), 8, 'all divisors of 24';
	}

    done_testing;
    exit;
}
