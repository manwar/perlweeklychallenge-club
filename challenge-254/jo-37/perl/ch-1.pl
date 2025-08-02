#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    a non-negative integer

EOS


### Input and Output

say qw(false true)[is_pow_3(shift)];


### Implementation

sub is_pow_3 ($n) {
	$n /= 3 while $n > 2 && !($n % 3);
    $n == 1; 
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  is_pow_3(27), 'example 1';
        ok !is_pow_3(0),  'example 2';
        ok !is_pow_3(6),  'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        for (my $n = 1; $n < 1e12; $n *= 3) {
            ok  is_pow_3($n), $n;
            ok !is_pow_3($n + 3), $n + 3;
        }
	}

    done_testing;
    exit;
}
