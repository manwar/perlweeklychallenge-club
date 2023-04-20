#!/usr/bin/perl -s

use v5.20;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use experimental 'signatures';

our ($tests, $examples, $verbose, $rot);
$rot //= 0;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-rot=ROT] [MATRIX]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-rot=ROT
    rotate given matrix by ROT * 90° clockwise

MATRIX
    a matrix in any form as accepted by the PDL string constructor

EOS


### Input and Output

main: {
    my $m = long "@ARGV";
    $m = rot_m($m) for 1 .. $rot;
    say $m;
}


### Implementation

sub rot_m ($m) {
	$m->xchg(0,1)->(-1:0);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my $m = long [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ];
        say $m = rot_m($m) for 1 .. 3;

    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
