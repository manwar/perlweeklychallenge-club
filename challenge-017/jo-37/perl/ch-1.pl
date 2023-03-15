#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Memoize;
use experimental 'signatures';
no warnings 'recursion';

memoize('ackermann');

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [M N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

M N
    calculate ackermann(M, N)

EOS


### Input and Output

say ackermann(@ARGV);


### Implementation

sub ackermann ($m, $n) {
    return $n + 1 unless $m;
    return ackermann($m - 1, 1) unless $n;
	ackermann($m - 1, ackermann($m, $n - 1));
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is ackermann(1, 2), 4;
        is ackermann(2, 3), 9;
        is ackermann(3, 4), 125;
        is ackermann(4, 0), 13;
        is ackermann(4, 1), 65533;
        is ackermann(5, 0), 65533;

    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
