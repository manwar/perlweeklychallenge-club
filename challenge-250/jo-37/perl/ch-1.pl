#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples, $base);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-base=B] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=B
    use B as base. Default: 10

N...
    list of numbers

EOS


### Input and Output

say smallest_index($base // 10, @ARGV);


### Implementation

sub smallest_index {
	my $base = shift;
    while (my ($i, $n) = each @_) {
        return $i if $n == $i % $base;
    }
    -1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is smallest_index(10,=> 0, 1, 2), 0, 'example 1';
        is smallest_index(10,=> 4, 3, 2, 1), 2, 'example 2';
        is smallest_index(10,=> 1, 2, 3, 4, 5, 6, 7, 8, 9, 0), -1, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is smallest_index(2,=> 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1), 9, 'base 2';
	}

    done_testing;
    exit;
}
