#!/usr/bin/perl -s

use v5.26;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    positive integer

EOS


### Input and Output

say "(@{[uniq_sum_zero(shift)]})";


### Implementation

sub uniq_sum_zero ($n) {
    (-$n / 2 .. -1, (0) x ($n % 2), 1 .. $n / 2);
}


### Examples and tests

sub run_tests {
    use List::Util qw(uniq sum);

    my sub test_usz {
        plan 2;
        is scalar(uniq @_), scalar @_, 'uniq';
        is sum(@_), 0, 'sum zero';
    }

    SKIP: {
        skip "examples" unless $examples;

        subtest 'example 1', \&test_usz, uniq_sum_zero(5);
        subtest 'example 2', \&test_usz, uniq_sum_zero(3);
        subtest 'example 3', \&test_usz, uniq_sum_zero(1);

    }

    SKIP: {
        skip "tests" unless $tests;

        subtest 'test 2', \&test_usz, uniq_sum_zero(2);
        subtest 'test 4', \&test_usz, uniq_sum_zero(4);
	}

    done_testing;
    exit;
}
