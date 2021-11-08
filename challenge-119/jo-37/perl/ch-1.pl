#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N ...] 

-examples
    run the examples from the challenge
 
-tests
    run some tests

N ...
    swap nibbles in N

EOS


### Input and Output

say swap_nibbles($_) for @ARGV;


### Implementation

# This works portably for N < 2**32 and potentially up to N < 2**64.  No
# need to restrict to N < 256.
sub swap_nibbles {
    no warnings 'portable';
	hex unpack 'h*', pack 'J>', shift;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is swap_nibbles(101), 86, 'example 1';
        is swap_nibbles(18), 33, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is swap_nibbles(0), 0, 'all zero';
        is swap_nibbles(255), 255, 'all one';
        is swap_nibbles(129), 24, 'swap outer bits to inner bits';
        is swap_nibbles(0xfedc), 0xefcd, '16 bit';
        is swap_nibbles(0xfedcba98), 0xefcdab89, '32 bit';
        no warnings 'portable';
        is swap_nibbles(0xfedcba9876543210), 0xefcdab8967452301, '64 bit';
	}

    done_testing;
    exit;
}
