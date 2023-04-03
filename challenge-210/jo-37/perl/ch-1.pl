#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util qw(sum max);
use List::UtilsBy qw(count_by);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

say kill_and_win(@ARGV);


### Implementation

# Brute force implementation.

sub kill_and_win {
    # Create a map from values to their frequencies.
	my %freq = count_by {$_} @_;
    # Find the maximum over three consectutive values.
    max map {
        sum map {$_ * ($freq{$_} // 0)} $_ - 1, $_, $_ + 1
    } keys %freq;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is kill_and_win(2, 3, 1), 6, 'example 1';
        is kill_and_win(1, 1, 2, 2, 2, 3), 11, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is kill_and_win(1, 1, 2, 2, 3, 3, 13), 13, 'single large value';
	}

    done_testing;
    exit;
}
