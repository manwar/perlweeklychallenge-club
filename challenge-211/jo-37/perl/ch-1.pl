#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [Matrix]

-examples
    run the examples from the challenge
 
-tests
    run some tests

Matrix
    a string representation of a matrix as accepted by the PDL constructor,
    e.g. "[3 2 1] [4 3 2]"

EOS


### Input and Output

say is_toeplitz("@ARGV") ? 'true' : 'false';


### Implementation

# A NxM matrix (N,M > 1) has N + M - 3 diagonals having more than one
# element.  Creating a set of NxN matrices where each of them have one
# of the orignal matrix' diagonals as its main diagonal.  Then take the
# diagonal of these matrices and re-arrange them into a new matrix
# having the main diagonals of the matrix series as rows. Taking minimum
# and maximum over the rows.  If min and max equals for every row, the
# matrix is Toeplitz.
# Note: Utilizing BAD values in incomplete diagonals that do not account
# for minimum or maximum.
sub is_toeplitz {
	(my $m = pdl @_)->badflag(1);
    my ($min, $max) = (
        cat map $_->diagonal(0, 1),
        $m->range($m->dim(0) - 2 - sequence(indx, 1, $m->shape->sum - 3),
            $m->dim(1), 't')
        ->reorder(1,2,0)->dog
    )->minmaximum;

    all $min == $max;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        
        ok is_toeplitz(
            [4, 3, 2, 1],
            [5, 4, 3, 2],
            [6, 5, 4, 3]), 'example 1';

        ok !is_toeplitz(
            [1, 2, 3],
            [3, 2, 1]), 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok is_toeplitz(sequence(4) + 5 - sequence(5)->dummy(0)), '4 x 5';
        ok is_toeplitz(sequence(5) + 4 - sequence(4)->dummy(0)), '5 x 4';

        my $nt = sequence(4) + 5 - sequence(5)->dummy(0);
        $nt->set(1, 4, 0);
        ok !is_toeplitz($nt), 'one element failing';
	}

    done_testing;
    exit;
}
