#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use experimental 'signatures';

our ($tests, $examples, $rows, $cols);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV && $rows && $cols;
usage: $0 [-examples] [-tests] [-rows=R -cols=C MATRIX]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-rows=R
-cols=C
    reshape the given matrix to RxC

MATRIX
    a matrix in any string form accepted by the pdl constructor, e.g.
    '[1 2] [3 4] [5 6]'

EOS


### Input and Output

# Build an output string to be printed or use zero if it turns out to be
# empty.
say +(join "\n", map "[@$_]", @{reshape_matrix($rows, $cols, "@ARGV")}) || 0;


### Implementation

# PDL's "reshape" is too forgiving for this task: It pads or truncates
# the data as needed.  Returning a reshaped matrix only when the number
# of elements in both shapes match.
sub reshape_matrix ($r, $c, @matrix) {
	my $m = long @matrix;

    $r * $c == nelem($m) ? $m->reshape($c, $r)->unpdl : [];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is reshape_matrix(1, 4, [1, 2], [3, 4]),
            [[1, 2, 3, 4]], 'example 1';
        is reshape_matrix(3, 2, [1, 2, 3], [4, 5, 6]),
            [[1, 2], [3, 4], [5, 6]], 'example 2';
        is reshape_matrix(3, 2, [1, 2]), [], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is reshape_matrix(3, 10, sequence(5, 6)), sequence(10, 3)->unpdl,
            '6x5 -> 3x10';
	}

    done_testing;
    exit;
}
