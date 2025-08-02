#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util 'sum0';

our ($tests, $examples, $bits);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless defined $bits and @ARGV;
usage: $0 [-examples] [-tests] [-bits=K] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-bits=K
    sum over numbers with a k-bit index

N...
    list of numbers

EOS


### Input and Output

say k_bit_sum($bits, @ARGV);


### Implementation

sub k_bit_sum {
	my $k = shift;

    sum0 @_[grep unpack('%32b*', pack('l', $_)) == $k, 0 .. $#_];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is k_bit_sum(1 ,=> 2, 5, 9, 11, 3), 17, 'example 1';
        is k_bit_sum(2 ,=> 2, 5, 9, 11, 3), 11, 'example 2';
        is k_bit_sum(0 ,=> 2, 5, 9, 11, 3), 2, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
