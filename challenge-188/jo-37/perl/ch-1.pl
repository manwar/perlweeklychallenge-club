#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use experimental 'signatures';

our ($tests, $examples, $K);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless $K && @ARGV > 1;
usage: $0 [-examples] [-tests] [-K=k N1 N2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-K=k
    Find pairs having a sum divisible by k

N1 N2...
    List of numbers

EOS


### Input and Output

say count_divisible_pairs(\@ARGV, $K);


### Implementation

# First step:
# - Build piddles of element pairs having a fixed index difference, i.e.
#   a lag of 1 .. len - 1
# - Stick these piddles together along their first dimension by gluing
#   on a null piddle.
# - Transpose the glued piddles, i.e. move the pairs to the front.
# - Sum over the pairs.
# Second step:
# - Pick all pair sums that are divisible by $k.
# - Count these.
sub count_divisible_pairs ($list, $k) {
	my $n = long $list;

    my $pairsum = null->glue(0, map $n->lags(0, $_, 2), 1 .. $n->dim(0) - 1)
        ->xchg(0, 1)->sumover;

    $pairsum->where(!($pairsum % $k))->dim(0);
}



### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_divisible_pairs([4, 5, 1, 6], 2), 2, 'Example 1';
        is count_divisible_pairs([1, 2, 3, 4], 2), 2, 'Example 2';
        is count_divisible_pairs([1, 3, 4, 5], 3), 2, 'Example 3';
        is count_divisible_pairs([5, 1, 2, 3], 4), 2, 'Example 4';
        is count_divisible_pairs([7, 2, 4, 5], 4), 1, 'Example 5';
    }

    SKIP: {
        skip "tests" unless $tests;
        
        is count_divisible_pairs([1, 4, 7, 10, 13, 16, 19, 22, 25, 28], 3),
            0, 'No divisible pair';
	}

    done_testing;
    exit;
}
