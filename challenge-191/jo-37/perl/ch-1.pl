#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    List of integers

EOS


### Input and Output

say twice_largest(@ARGV);


### Implementation
#
# The task requires careful reading: Operating on *items*, not on
# *values*.  This differentiation becomes crucial if the maximum is not
# taken on a unique item.  Interpreting this task as: Take the largest
# two items from the list and check if the first is at least twice the
# second.

sub twice_largest {
    state $w = long(1, -2)->dummy(0);

    my $n = long(@_);
    # Find the indices of the two largest items.
    maximum_n_ind($n, my $max2 = zeroes(indx, 2));

    # Check if the maximum item is at least twice the next.  As items
    # are integers, we may compare the scalar product of the maximum two
    # items with the weight vector against -0.5 to gain the requested
    # -1/1 result.
    ($n->index($max2) x $w)->sclr <=> -0.5;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is twice_largest(1, 2, 3, 4), -1, 'Example 1';
        is twice_largest(1, 2, 0, 5),  1, 'Example 2';
        is twice_largest(2, 6, 3, 1),  1, 'Example 3';
        is twice_largest(4, 5, 2, 3), -1, 'Example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is twice_largest(1, 3, 3), -1, 'non-unique max';
        is twice_largest(-10, 1, -20), 1, 'negative items';
	}

    done_testing;
    exit;
}
