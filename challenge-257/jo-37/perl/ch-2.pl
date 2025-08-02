#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [M]

-examples
    run the examples from the challenge
 
-tests
    run some tests

M
    a matrix in any form accepted by the PDL string constructor, e.g.
    '[[0, 1,-2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]'

EOS


### Input and Output

say 0 + !!is_reduced_echelon("@ARGV");


### Implementation

sub is_reduced_echelon {
	my $m = pdl @_;

    my $allones = whichND($m == 1);
    my $firstidx = which($allones->(1)->enumvec == 0);
    my $firstones = $allones->dice('X', $firstidx);
    return unless $firstones->dim(1) < 2 ||
        all $firstones((0),0:-2) < $firstones((0),1:-1);
    for my $firstone ($firstones->dog) {
        my ($col, $row) = $firstone->list;
        return unless 1 == sum $m->dice('X', $row)->(0:$col) != 0;
        return unless 1 == sum $m->dice($col, 'X')->(,0:$row) != 0;
    }
    my $zeros = which $m->orover == 0;
    return unless !$firstones->ngood || !$zeros->ngood ||
        $firstones->((1))->max < $zeros->min;
    
    return unless $zeros->dim(0) + $firstidx->dim(0) == $m->dim(1);
    
    1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok !is_reduced_echelon([
                [1, 1, 0],
                [0, 1, 0],
                [0, 0, 0]
            ]), 'example 1';

        ok is_reduced_echelon([
                [0, 1,-2, 0, 1],
                [0, 0, 0, 1, 3],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]
            ]), 'example 2';

        ok is_reduced_echelon([
                [1, 0, 0, 4],
                [0, 1, 0, 7],
                [0, 0, 1,-1]
            ]), 'example 3';

        ok !is_reduced_echelon([
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0]
             ]), 'example 4';

        ok !is_reduced_echelon([
                [0, 1, 0],
                [1, 0, 0],
                [0, 0, 0]
             ]), 'example 5';

        ok !is_reduced_echelon([
                [4, 0, 0, 0],
                [0, 1, 0, 7],
                [0, 0, 1,-1]
             ]), 'example 6';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok is_reduced_echelon([
                [0, 0, 0],
                [0, 0, 0]
            ]), 'zero matrix';

        ok is_reduced_echelon([
                [0, 0, 1],
                [0, 0, 0]
            ]), 'single row';
	}

    done_testing;
    exit;
}
