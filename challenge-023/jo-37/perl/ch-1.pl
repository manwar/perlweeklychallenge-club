#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples, $order);
$order //= 1;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-order=N] [K...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-order=N
    find forward difference sequence of order N. Default: 1
    
K...
    list of numbers

EOS


### Input and Output

say "@{diff($order, @ARGV)}";


### Implementation

sub diff {
    my $n = shift;
    my $l = pdl @_;
    $l = $l(1:-1) - $l(0:-2) for 1 .. $n;
    $l->unpdl;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is diff(1, [5, 9, 2, 8, 1, 6]),
            [4, -7, 6, -7, 5], 'example 1';
        is diff(2, [5, 9, 2, 8, 1, 6]),
            [-11, 13, -13, 12], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
