#!/usr/bin/perl -s

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

say count_reverse_pairs(@ARGV);


### Implementation

# Count element pairs where $j > $i and $nums[$i] > 2 * $nums[$j].

sub count_reverse_pairs {
	my $nums = long @_;

    ((sequence($nums) > sequence(1, $nums->dim(0)))
        & ($nums->dummy(0) > 2 * $nums))->sum;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_reverse_pairs(1, 3, 2, 3, 1), 2, 'example 1';
        is count_reverse_pairs(2, 4, 3, 5, 1), 3, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is count_reverse_pairs(1, 0, -1), 3, 'zero and negative';
	}

    done_testing;
    exit;
}
