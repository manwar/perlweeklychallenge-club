#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use List::Util 'uniqnum';

our ($tests, $examples, $n);

$n //= 3;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-n=N
    find N-th largest element. Default: 3

N...
    list of integers

EOS


### Input and Output

say nth_max($n, @ARGV);


### Implementation

# Keep N in the "N-th" largest element variable.

sub nth_max {
    my $n = shift;
    # Not using PDL's "uniq" because it would sort the data.  There's a
    # significant difference in running time for larger lists.
	my $l = pdl uniqnum @_;
    
    # The "otherwise" branch: there is no n-th maximal element.
    return max $l if $l->nelem < $n;

    # Find the indices of the n largest elements.  Populates the second
    # argument in its given size.
    maximum_n_ind $l, my $max_ind = zeroes indx, $n;

    # Pick the element indexed by the last in list, which is the n-th
    # largest.
    $l($max_ind(-1))->sclr;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is nth_max(3, (5, 3, 4)), 3, 'example 1';
        is nth_max(3, (5, 6)), 6, 'example 2';
        is nth_max(3, (5, 4, 4, 3)), 3, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is nth_max(3, (3, 4, 3, 4, 3)), 4, 'not enought unique numbers';
	}


    done_testing;
    exit;
}
