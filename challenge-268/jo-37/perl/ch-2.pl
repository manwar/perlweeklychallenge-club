#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples, $num);
$num ||= 2;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV && !(@ARGV % $num);
usage: $0 [-examples] [-tests] [-num=N] [--] [M]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-num=N
    move N-tuples. Default: 2

M...
    list of numbers with a multiple of N as size

EOS


### Input and Output

main: {
    local $" = ', ';
    say "(@{number_game($num, \@ARGV)})";
}


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/05/10/ch-268.html#task-2


sub number_game {
    my $n = shift;
    long(@_)->qsort->splitdim(0, $n)->(-1:0)->flat;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is number_game(2, [2, 5, 3, 4])->unpdl, [3, 2, 5, 4], 'example 1';
        is number_game(2, [9, 4, 1, 3, 6, 4, 6, 1])->unpdl,
            [1, 1, 4, 3, 6, 4, 9, 6], 'example 2';
        is number_game(2, [1, 2, 2, 3])->unpdl, [2, 1, 3, 2], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is number_game(3, [1 .. 12])->unpdl,
            [3, 2, 1, 6, 5, 4, 9, 8, 7, 12, 11, 10], 'triplets';

	}

    done_testing;
    exit;
}
