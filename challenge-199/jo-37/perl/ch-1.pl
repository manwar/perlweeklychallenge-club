#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS if @ARGV < 2;
usage: $0 [-examples] [-tests] [N1 N2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N1 N2...
    list of numbers

EOS


### Input and Output

say count_good_2(@ARGV);


### Implementation

# This task may be regarded as a simplified variant of challenge 196/1.
# The first transformation step is from index i to index j > i having
# the same value.  The second step goes from index j to index k < j
# having the same value again, where i shall be equal to k.  The
# possible starting indices then are given by the nonzero elements in
# the diagonal of the product matrix.  Actually, the diagonal has the
# number of solutions for every starting index and thus the sum over the
# diagonal is the requested number of good pairs.
# See
# https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-196/jo-37/perl/ch-1.pl
# for details.

sub count_good_2 {
	my $l = long @_;
    # Matrix indicating pairs of equal values in the list.
    my $eqt = ($l == $l->dummy(0));
    # Combining the value transition matrix and the index transition
    # matrix by invalidating the upper right triangle values (including
    # the diagonal) utilizing symmetry.
    $eqt->where($l->sequence >= $l->sequence->dummy(0)) .= 0;

    # Chain the transition matrix with its transposed and sum over the
    # diagonal.
    ($eqt->xchg(0, 1) x $eqt)->diagonal(0, 1)->sum;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_good_2(1, 2, 3, 1, 1, 3), 4, 'example 1';
        is count_good_2(1, 2, 3), 0, 'example 2';
        is count_good_2(1, 1, 1, 1), 6, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
