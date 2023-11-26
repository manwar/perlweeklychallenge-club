#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

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

say max_greatness(@ARGV);


### Implementation

# First we we sort the list of numbers in descending order and make a
# copy thereof as the remaining numbers.  Then, for every number in the
# sorted list, we check if the largest (i.e. first) remaining number is
# larger.  If so, we remove the largest number from the remaining
# numbers and count one place of greatness.  Otherwise we remove the
# smallest number from the remaining numbers.
# Why does this work?
# - The current number cannot contribute to the greatness if there is no
#   larger number in the list of remaining numbers.  Therefore we may
#   pick the smallest remaining number available.
# - Suppose there is a number in the remaining list that is larger than
#   the current number.  Then there is a rightmost (i.e. minimum) k-th
#   such number in the list of remaining numbers.  It is easy to see
#   that the first k remaining numbers are all strictly larger than the
#   next k numbers from the sorted list.  Thus we may choose any of the
#   first k remaining numbers for any of the next numbers from the
#   sorted list.  To keep things simple, we choose the first (i.e.
#   maximum) remaining number for the current number.

sub max_greatness {
	my @remaining = my @sorted = sort {$b <=> $a} @_;
    my $greatness = 0;
    splice @remaining, $_ < $remaining[0] ? do {$greatness++; 0} : -1, 1
        for @sorted;

    $greatness;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is max_greatness(1, 3, 5, 2, 1, 3, 1), 4, 'example 1';
        is max_greatness(1, 2, 3, 4), 3, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is max_greatness(2,2,3,3,3,4,5,5,5), 6, 'can select the max';
	}

    done_testing;
    exit;
}
