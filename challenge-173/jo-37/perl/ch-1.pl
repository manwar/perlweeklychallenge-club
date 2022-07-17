#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util 'todigits';
use List::Util 'reduce';
use experimental 'signatures';

our ($tests, $examples, $base);
$base ||= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-base=B] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=B
    Use base B (Default: 10).

N
    Check if N (decimal) is an "esthetic number" in base B.

EOS


### Input and Output

say 0 + !!is_esthetic(shift, $base);


### Implementation

# Generalizing the task to arbitrary bases as usual.
#
# Taking the liberty of modifying the task slightly.  Shouldn't the
# difference of two digits in a positional representation with base B be
# taken modulo B?  Zero comes after nine in decimal numbers.  I'm going
# to follow this interpretation.
# A difference D between two digits of one or minus one may be expressed
# as:
# (D - 1) * (D + 1) = 0
# or
# D ** 2 = 1
# Taking these equations modulo B, they make "B - 1" and "zero"
# neighbors.

sub is_esthetic ($n, $base) {
    # Turn zero to true.
    defined reduce {
        # Slide over digit pairs and check their difference.
        defined $a && ($b - $a)**2 % $base == 1 ? $b : undef
    } todigits $n, $base;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok is_esthetic(5456, 10), 'example 1';
        ok !is_esthetic(120, 10), 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok is_esthetic(901, 10), 'nine to zero to one';
        ok is_esthetic(6969, 4), '1230321(4)';
        ok is_esthetic(067076, 8), '67076(8)';
        ok is_esthetic('1234567890987654321012345678909876543210123456789098765432101234567890987654321012345678909876543210123456789098765432101234567890987654321012345678909876543210', 10), 'saw-toothed';
	}

    done_testing;
    exit;
}
