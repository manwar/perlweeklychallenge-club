#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use List::Util 'uniqnum';
use Math::Prime::Util qw(fromdigits todigits);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    Calculate the sum over pairwise and'ed values.

EOS


### Input and Output

# The term "for all unique pairs" is a bit vague.  Taking unordered
# pairs of different numbers here.
say sum_bit_pair_wise(uniqnum @ARGV);


### Implementation

# There is no need to loop over pairs to solve this task.  Taking the
# numbers' binary representation and adding the digits at a specific
# position gives the count C of numbers having this bit set.  Then the
# number of pairs having this bit set is C * (C - 1) / 2.  Taking a
# pseudo-binary number from these "digits" gives the requested sum.
# Here PDL comes handy for several reasons:
# - Missing/undefined values on piddle creation are taken as zero by
#   default.
# - There is a simple transpose operation.
# - There are projections over one dimension, e.g. sumover.
# - The data in any dimension can easily be reversed.
# - Piddle values can be transformed "simultaneously".

sub sum_bit_pair_wise {
    # By reversing the digits, these become aligned at the least
    # significant position even if the binary representations (without
    # leading zeros) have different lengths.  Missing digits will be
    # taken as zeros by the PDL constructor.  Then sum over each bit
    # position and revert the reverse operation.
    my $sum = (long map [reverse todigits $_, 2], @_)
        ->xchg(0, 1)->sumover->slice('-1:0');
    # Calculate the number of pairs having a certain bit in common and
    # build the requested sum from these "binary" digits.  'fromdigits'
    # is not limited to digits below the base and is thus able to handle
    # these.
    fromdigits +($sum * ($sum - 1) / 2)->unpdl, 2;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        
        is sum_bit_pair_wise(1, 2, 3), 3, 'example 1';
        is sum_bit_pair_wise(2, 3, 4), 2, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is sum_bit_pair_wise(0 .. 7), 42,
            'Ultimate Question to Life, the Universe, and Everything';
        is sum_bit_pair_wise(1, 4, 9, 13), 15, 'asymmetric';
	}

    done_testing;
    exit;
}
