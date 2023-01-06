#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of integers

EOS


### Input and Output

say count_max_gap(@ARGV);


### Implementation

# Sort the numbers, build pairs of adjacent values, take the differences
# of the pairs by flipping the sign of the second elements and summing
# over the pairs.  Then count the elements having the maximum value.
sub count_max_gap {
    return 0 unless @_ > 1;
    my $gap = sumover long(@_)->qsort->lags(0, 1, 2)->xchg(0, 1) * long 1, -1;

    $gap->where($gap == max $gap)->dim(0);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_max_gap(qw(2 5 8 1)), 2, 'example 1';
        is count_max_gap(3), 0, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is count_max_gap(qw(8 6 4 3 2 1)), 2, 'max count not at max gap';
        is count_max_gap(qw(3 3 3)), 2, 'zero gap';
        is count_max_gap(qw(5 3 2 1)), 1, 'single max gap';
        is count_max_gap(qw(1 2 3 -1)), 1, 'negative number in max gap';
        is count_max_gap(2, 1), 1, 'single gap';
        is count_max_gap(), 0, 'empty list';
	}

    done_testing;
    exit;
}
