#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

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

say "(@{lrsd(@ARGV)})";


### Implementation

# Assuming there is a little mistake in the task description.  Deviating
# from the examples, the five element list results in four element lists
# for the left and right sums and therefore for the result, too.
# Following the examples instead.

sub lrsd {
	my $l = long \@_;

    # "range" with a boundary condition of "truncate" provides the
    # requested leading / trailing zero.  The remaining operations
    # should be self-explanatory.
    abs(
        $l->range(-1, $l->dim(0), 't')->cumusumover
        - $l(-1:0)->range(-1, $l->dim(0), 't')->cumusumover->(-1:0)
    )->unpdl;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is lrsd(10, 4, 8, 3), [15, 1, 11, 22], 'example 1';
        is lrsd(1), [0], 'example 2';
        is lrsd(1, 2, 3, 4, 5), [14, 11, 6, 1, 10], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
