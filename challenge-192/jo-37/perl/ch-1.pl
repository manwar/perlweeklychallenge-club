#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    integer to be bit-flipped in decimal, hexadecimal, octal or binary
    notation

EOS


### Input and Output

# Interpret or numify the input string
say flip_bits(/^0/ ? oct : 0 + $_) for shift;


### Implementation

# Extending the task to any integer.  Negative values work out-of-the
# box, but zero needs a closer examination.  As zero has no bit set, it
# has no significant bit.  To be able to flip one single zero-bit, we
# need this single bit to be regarded significant. 

sub flip_bits ($n) {
    # Get the bit left of the highest significant bit from a copy of $n.
    # This value minus one masks all relevant bits.
    # Edge cases:
    # - 0b0 and 0b1 both lead to $l = 0b10 and a mask of 0b1.
    # - If the bit in $l gets shifted out, $l becomes zero and the
    #   mask -1, i.e. all bits set.
    my ($c, $l) = ($n, 2);
    $l <<= 1 while $c >>= 1;

    # Flip bits and mask the significant bits.
    ~$n & ($l - 1);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is flip_bits(5), 2, 'Example 1';
        is flip_bits(4), 3, 'Example 2';
        is flip_bits(6), 1, 'Example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is flip_bits(0), 1, 'out of scope: 0';
        is flip_bits(-1), 0, 'out of scope: -1';
        is flip_bits(-2), 1, 'out of scope -2';
        is flip_bits(0x8000), 0x7fff, 'flip 16 bits';
        is flip_bits(85), 42, 'The universal question';
        {
            no warnings 'portable';
            is flip_bits(0x8000000000000000), 0x7fffffffffffffff,
            'flip 64 bits';
        }
	}

    done_testing;
    exit;
}
