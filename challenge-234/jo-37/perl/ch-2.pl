#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util 'pairvalues';
use List::MoreUtils 'frequency';
use Math::Prime::Util qw(vecprod forcomb);

our ($tests, $examples, $k);
$k //= 3;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-k=K] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-k=K
    count index-k-combinations resulting in unequal
   ch-2 value-k-combinations. Default: 3.

N...
    list of numbers

EOS


### Input and Output

say nonequal_comb($k, @ARGV);


### Implementation

# Generalizing the task from triplets to k-combinations.
# Transform the list of integers to a list of frequencies for each
# number in the list.  Then loop over all k-combinations of the
# frequencies, representing all k-combinations of the list's unique
# elements.  The elements of such a k-combination are all pairwise
# distinct.  Each such k-combination may be constructed by selecting any
# of the numbers' occurrence within the list.  Thus every k-combination
# has a multitude of the product of all the frequencies of the elements
# within the k-combination.

sub nonequal_comb {
    my $k = shift;
    my @freq = pairvalues frequency @_;
    my $sum = 0;
    forcomb {$sum += vecprod @freq[@_]} @freq, $k;
    
    $sum;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is nonequal_comb(3, 4, 4, 2, 4, 3), 3, 'example 1';
        is nonequal_comb(3, 1, 1, 1, 1, 1), 0, 'example 2';
        is nonequal_comb(3, 4, 7, 1, 10, 7, 4, 1, 1), 28, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is nonequal_comb(4, 1, 2, 3, 4, 5), 5, '4-combs from 5 numbers';
        is nonequal_comb(3, (1, 2, 3) x 1000), 1e9, 'do not enumerate these';
	}

    done_testing;
    exit;
}
