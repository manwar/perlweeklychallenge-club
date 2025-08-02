#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [F]

-examples
    run the examples from the challenge
 
-tests
    run some tests

F
    field coordinate

EOS


### Input and Output

say +(qw(false true))[check_color(shift)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/08/09/ch-281.html#task-1


sub check_color {
    my ($col, $row) = shift =~ /^([a-h])([1-8])$/ or die "field invalid";

    (ord($col) - ord('a') + $row - 1) % 2;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  check_color('d3'), 'example 1';
        ok !check_color('g5'), 'example 2';
        ok  check_color('e6'), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
    }

    done_testing;
    exit;
}
