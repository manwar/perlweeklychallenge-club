#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(todigits fromdigits);
use List::MoreUtils 'firstidx';
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
    find the smallest number having the same number of "ones" in its
    binary representation and is larger than N

EOS


### Input and Output

say num_bits_next(shift);


### Implementation

sub num_bits_next ($n) {
    # Convert the number to its binary representation with a leading 0.
    my @bits = (0, todigits $n, 2);

    # Find the position of the least significant 0-bit that has a
    # subsequent 1-bit and count the number of 1-bits on the way.
    my $bits;
    my $zero = $#bits - firstidx {
        $bits && !$_ ? 1 : ($bits += $_, 0);
    } reverse @bits;

    # Assemble the new number from:
    # - all bits preceding the identified 0-bit
    # - the 0 flipped to 1
    # - one more 0 than the number of subsequent 0.
    # - one less 1 than the number of subsequent 1.
    fromdigits [
        @bits[0 .. $zero - 1],
        1,
        (0) x (@bits - $zero - $bits),
        (1) x ($bits - 1)
    ], 2;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is num_bits_next(3), 5, 'example 1';
        is num_bits_next(12), 17, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        # http://oeis.org/A000079
        # Powers of 2
        is num_bits_next(1), 2;
        is num_bits_next(2), 4;
        is num_bits_next(4), 8;

        # http://oeis.org/A018900
        # Sums of two distinct powers of 2
        is num_bits_next(3), 5;
        is num_bits_next(5), 6;
        is num_bits_next(6), 9;
        is num_bits_next(9), 10;
        is num_bits_next(10), 12;

        # http://oeis.org/A014311
        # Numbers with exactly 3 ones in binary expansion.
        is num_bits_next(7), 11;
        is num_bits_next(11), 13;
        is num_bits_next(13), 14;
        is num_bits_next(14), 19;
        is num_bits_next(19), 21;

        # http://oeis.org/A014312
        # Numbers with exactly 4 ones in binary expansion.
        is num_bits_next(15), 23;
        is num_bits_next(23), 27;
        is num_bits_next(27), 29;
        is num_bits_next(29), 30;
        is num_bits_next(30), 39;
	}

    done_testing;
    exit;
}
