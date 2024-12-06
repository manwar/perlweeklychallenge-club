#!/usr/bin/perl -s

use v5.12;
use Test2::V0 '!float', '!E';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [B]

-examples
    run the examples from the challenge
 
-tests
    run some tests

B
    binary matrix in any form accepted by the PDL string constructor,
    e.g. '[1,1,0],[1,1,1],[0,1,1]'

EOS


### Input and Output

say max_square("@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/12/06/ch-298.html#task-1


sub max_square {
    my $m = long @_;
    $m = $m->dummy(1) if $m->ndims < 2;
    for (my $len = 1;; $len++) {
        return ($len - 1)**2 if !any($m);
        return $len**2 if min($m->shape) < 2;
        $m = $m->range(ndcoords($m(0:-2,0:-2)), 2)
            ->reorder(2, 3, 0, 1)->andover->andover;
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is max_square([1, 0, 1, 0, 0],
                      [1, 0, 1, 1, 1],
                      [1, 1, 1, 1, 1],
                      [1, 0, 0, 1, 1]), 4, 'example 1';
        is max_square([0, 1],
                      [1, 0]), 1, 'example 2';
        is max_square([0]), 0, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is max_square([1, 0, 1, 0, 0, 1],
                      [1, 0, 1, 1, 1, 1],
                      [1, 1, 1, 1, 1, 1],
                      [1, 0, 0, 1, 1, 1]), 9, 'extended example 1';
        is max_square([1, 1, 1],
                      [1, 1, 1],
                      [1, 1, 1]), 9, 'full size';
        is max_square([1, 1, 1, 1],
                      [1, 1, 1, 1],
                      [1, 1, 1, 1]), 9, 'non-square full size';
        is max_square([1, 1, 0, 1],
                      [1, 1, 1, 1],
                      [1, 0, 1, 1]), 4, 'non-square';
        is max_square([0, 0, 1]), 1, 'one row';
        is max_square([0], [0], [1]), 1, 'one column';
        is max_square(rvals(31, 31, {centre => [15, 15]}) <= 7),
            81, 'circle 7';
        is max_square(rvals(255, 255, {centre => [127, 127]}) <= 63),
            7921, 'circle 63';
    }

    done_testing;
    exit;
}
