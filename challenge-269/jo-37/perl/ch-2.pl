#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use POSIX qw(Inf NaN);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

I...
    list of integers

EOS


### Input and Output

say "(@{[join ', ', de(@ARGV)]})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/05/17/ch-269.html#task-2


sub de {
    my @arr;
    push @{$arr[($arr[0][-1] // NaN) <= ($arr[1][-1] // Inf)]}, $_ for @_;
    map @$_, @arr;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [de(2, 1, 3, 4, 5)], [2, 3, 4, 5, 1], 'example 1';
        is [de(3, 2, 4)], [3, 4, 2], 'example 2';
        is [de(5, 4, 3, 8)], [5, 3, 4, 8], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [de(2, 1, 1, 3)], [2, 1, 1, 3], 'not unique';

	}

    done_testing;
    exit;
}
