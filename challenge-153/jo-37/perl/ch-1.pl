#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use bigint;
use Coro::Generator;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    Print the first N left factorials.

EOS


### Input and Output

main: {
    my $left_factorial = gen_left_factorial();
    say $left_factorial->() for 1 .. $ARGV[0];
}


### Implementation

# Build a generator for left factorials
sub gen_left_factorial {
    my ($index, $factorial, $left_factorial) = (0, 1, 1);

    generator {
        yield $left_factorial;
        yield $left_factorial += ($factorial *= ++$index) while 1;
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my $left_factorial = gen_left_factorial();
        is [map $left_factorial->(), 1 .. 10],
            [1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114], 'task 1';
    }

    SKIP: {
        skip "tests" unless $tests;

        my $left_factorial = gen_left_factorial();
        $left_factorial->() for 1 .. 21;
        is $left_factorial->(), 53652269665821260314, 'from OEIS';
	}

    done_testing;
    exit;
}
