#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use bigint;
use Math::Prime::Util qw(numtoperm permtonum factorial);

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [PERM]

-examples
    run the examples from the challenge
 
-tests
    run some tests

PERM
    permutation of numbers 1..N

EOS


### Input and Output

say "(@{[next_permutation(@ARGV)]})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/08/ch-294.html#task-2


sub next_permutation {
    my @perm = map $_ - 1, @_;
    my $p = permtonum(\@perm) + 1;

    $p == factorial(@perm) ? () : map $_ + 1, numtoperm(@perm, $p);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is [next_permutation(1, 2, 3)], [1, 3, 2], 'example 1';
        is [next_permutation(2, 1, 3)], [2, 3, 1], 'example 2';
        is [next_permutation(3, 1, 2)], [3, 2, 1], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
        is [next_permutation(3, 2, 1)], [], 'no next';
    }

    done_testing;
    exit;
}
