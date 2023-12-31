#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [DI]

-examples
    run the examples from the challenge
 
-tests
    run some tests

DI
    a string consisting of 'D's and 'I's

EOS


### Input and Output

say "(@{[arrange_di(shift)]})";


### Implementation

# First we transform the DI-string into an array of zeroes and ones
# where a zero represents a decrement and a one an increment.  Lets
# assume the DI-string and the corresponding array have a length of L,
# there are ND 'D's / zeroes and NI 'I's / ones.
# Then we create two sequences:
# - SD as the numbers 0 .. ND - 1 in descending order
# - SI the numbers ND .. L - 1 in ascending order.
# It can be seen that:
# - Every element of SI is larger than any element of SD.
# - Every element of SD is smaller than any element of SI.
# - Every but the last element of SI is smaller than its successor.
# - Every but the last element of DI is larger than its successor.
# Now we can construct a permutation with the required incremental /
# decremental behaviour by successively picking the first element from
# the corresponding sequence - except for the very first.
# The first element of our permutation may be chosen as follows:
# - If the first step is a decrement, we just take L as the first
#   element.
# - Otherwise, we pick the first element from the incremental sequence SI
#   and append L to SI

sub arrange_di {
	my @di = map tr/DI/01/r, split //, shift;
    my @count = (0, 0);
    $count[$_]++ for @di;
    my @pool = ([reverse 0 .. $count[0] - 1], [$count[0] .. $#di]);

    ($di[0] ?
        do {push $pool[1]->@*, scalar @di; shift $pool[1]->@*} :
        scalar @di,
        map shift $pool[$_]->@*, @di);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [arrange_di('IDID')], [2, 3, 1, 4, 0], 'example 1';
        is [arrange_di('III')], [0, 1, 2, 3], 'example 2';
        is [arrange_di('DDI')], [3, 1, 0, 2], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
