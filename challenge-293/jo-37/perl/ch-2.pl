#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [P1 P2 P3]

-examples
    run the examples from the challenge
 
-tests
    run some tests

P1 P2 P3
    three points in the form X,Y

EOS


### Input and Output

#say solve_task();
say +(qw(false true))[is_boomerang(map [split /,/, $_], @ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/08/ch-293.html#task-2


sub is_boomerang {
    my $p = long @_;

    !!($p(,1:-1) - $p(,0:-2))->determinant
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  is_boomerang( [1, 1], [2, 3], [3, 2] ), 'example 1';
        ok !is_boomerang( [1, 1], [2, 2], [3, 3] ), 'example 2';
        ok  is_boomerang( [1, 1], [1, 2], [2, 3] ), 'example 3';
        ok !is_boomerang( [1, 1], [1, 2], [1, 3] ), 'example 4';
        ok !is_boomerang( [1, 1], [2, 1], [3, 1] ), 'example 5';
        ok  is_boomerang( [0, 0], [2, 3], [4, 5] ), 'example 6';
    }

    SKIP: {
        skip "tests" unless $tests;
    }

    done_testing;
    exit;
}
