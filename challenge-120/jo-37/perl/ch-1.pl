#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    number(s)

EOS


### Input and Output

say swap_bits($_) for @ARGV;


### Implementation

sub swap_bits ($n) {
    no warnings 'portable';
    # Set $odd to a mask with all odd bits set in the maximum internal
    # representation.
    # Oops! There was a restriction to N < 256 again.  Realized it only
    # after the full-size solution had been finished.
    state $odd = hex 5 x ((unpack '%b*', pack 'j', -1) / 4);

    # Right-shift even bits and left-shift odd bits.
    ($n & ($odd << 1)) >> 1 | ($n & $odd) << 1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is swap_bits(101), 154, 'example 1';
        is swap_bits(18), 33, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is swap_bits(0), 0, 'no bit set';
        is swap_bits(~0), ~0, 'all bits set';
        is swap_bits(0x55555555), 0xaaaaaaaa, 'odd to even';
        is swap_bits(0xaaaaaaaa), 0x55555555, 'even to odd';
	}

    done_testing;
    exit;
}
