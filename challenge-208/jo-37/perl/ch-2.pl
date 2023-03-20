#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util qw(uniqint sum);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

main: {
    my ($dup, $miss) = dup_miss(@ARGV);
    say $dup || $miss ? "($dup,$miss)" : -1;
}


### Implementation

sub dup_miss {
    # - A single duplicate value is the difference between the sum over
    #   all elements and the sum over the unique elements.
    # - A single missing value is the difference between the sum over
    #   all expected elements and the sum over the unique elements.
    my $usum = sum uniqint @_;
    map $_ - $usum, sum(@_), @_ * (@_ + 1) / 2;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is [dup_miss(1, 2, 2, 4)], [2, 3], 'example 1';
        is [dup_miss(1, 2, 3, 4)], [0, 0], 'example 2';
        is [dup_miss(1, 2, 3, 3)], [3, 4], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
