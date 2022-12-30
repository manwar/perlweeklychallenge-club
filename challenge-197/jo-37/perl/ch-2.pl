#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::MoreUtils qw(zip part);

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

say "@{[wiggle_sort(@ARGV)]}";


### Implementation

# Sort the list in descending order, split it in two and zip both parts.
# For an odd sized list, the first part gets one more element.  "zip"
# will then produce a trailing "undef" that will be omitted by the
# slice.
# If the list contains too many replicas of the same element then there
# is no valid wiggle sorted list and the produced result will silently
# violate the constraints.
sub wiggle_sort {
    my $i;
    (&zip(
        part {$i++ < $#_ / 2}
        sort {$b <=> $a} @_
    ))[0 .. $#_];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is [wiggle_sort(qw(1 5 1 1 6 4))], [qw(1 6 1 5 1 4)], 'example 1';
        is [wiggle_sort(qw(1 3 2 2 3 1))], [qw(2 3 1 3 1 2)], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is [wiggle_sort(qw(1 2 3 4 5))], [qw(3 5 2 4 1)], 'odd size';
        is [(wiggle_sort(qw(1 1 1 1 1 2 3 4)))[6, 7]], [1, 1], '1 violates';
        is [(wiggle_sort(qw(1 2 3 4 4 4 4)))[0, 1]], [4, 4], '4 violates';
        is [wiggle_sort(-1, 0, 1)], [0, 1, -1], 'negative';
	}

    done_testing;
    exit;
}
