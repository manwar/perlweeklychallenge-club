#!/usr/bin/perl -s

use v5.16;
use PDL;
use Test2::V0 '!float';
use experimental qw(signatures postderef);

our ($tests, $examples);
$PDL::whichND = 's';

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [row1 ... rowN]

-examples
    run the examples from the challenge
 
-tests
    run some tests

row1 ... rowN
    The matrix by rows. Use whitspace separated values for each single
    row, e.g.
    $0 '1 0 0' '1 0 0'

EOS


### Input and Output

# Generate a zero matrix in the found dimensions.  It's a fake, but one
# zero matrix is as good any zero matrix - as long as their dimensions
# agree.
say zeros(zero_submatrix(byte join ';', @ARGV)->@*);


### Implementation

# Loop over all sub matrix dimensions in descending size down from the
# given matrix' dimensions and stop at the first all-zero sub matrix
# hit. 
sub zero_submatrix ($m) {
    # The loop variable is a 1-d index piddle holding the sub matrix
    # dimensions.
    for my $dims (sort {prod($b) <=> prod($a)}
        (ndcoords(indx, $m)->clump(1, 2) + 1)->dog) {
            # Build "array ref syntax" slice arguments such that a sub
            # matrix of the current dimensions having an upper left
            # element inside the resulting slice fits into the full
            # matrix, i.e.  a "PDL way" to get [[0, -dim0], [0, -dim1]]
            # from [dim0, dim1]
            my $slice = indx(0, 0)->cat(-$dims)->xchg(1, 0)->unpdl;
            # Select all sub matrices in the current dimensions having a
            # zero as the upper left element, take the logical "or" over
            # the values therein and return the current dimensions as an
            # array ref if there is an all-zero sub matrix.
            return $dims->unpdl if !all 
                $m->range(whichND(!$m->slice(@$slice)), $dims)
                ->reorder(1, 2, 0)->orover->orover;
    }
    return [0, 0];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        # 2x3 and 3x2 are both valid.
        like zero_submatrix(byte(
            [1, 0, 0, 0, 1, 0],
            [1, 1, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 0])),
            bag {item 2; item 3; end;}, 'example 1';
        is zero_submatrix(byte(
            [0, 0, 1, 1],
            [0, 0, 0, 1],
            [0, 0, 1, 0])), [2, 3], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        like zero_submatrix(byte(
            [1, 0, 0, 0, 0, 0],
            [1, 1, 0, 0, 1, 0],
            [1, 0, 0, 0, 0, 0])),
            [2, 3], 'like example 1, forced to 2x3';
        is zero_submatrix(byte(
            [1, 1],
            [1, 1])), [0, 0], 'no zero';
        is zero_submatrix(byte(
            [1, 0],
            [1, 1])), [1, 1], 'single zero';
        is zero_submatrix(byte(
            [0, 0],
            [0, 0],
            [0, 0])), [2, 3], 'full size';
        is zero_submatrix(byte(
            [0, 0, 0],
            [0, 0, 1],
            [0, 0, 0],
            [0, 1, 0])), [2, 3], 'upper left';
        is zero_submatrix(byte(
            [0, 0, 0],
            [1, 0, 0],
            [0, 0, 0],
            [0, 1, 0])), [2, 3], 'upper right';
        is zero_submatrix(byte(
            [0, 1, 0],
            [0, 0, 0],
            [0, 0, 1],
            [0, 0, 0])), [2, 3], 'lower left';
        is zero_submatrix(byte(
            [0, 1, 0],
            [0, 0, 0],
            [1, 0, 0],
            [0, 0, 0])), [2, 3], 'lower right';
	}

    done_testing;
    exit;
}
