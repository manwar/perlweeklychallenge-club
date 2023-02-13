#!/usr/bin/perl -s

use v5.22;
use Test2::V0;
use Math::Prime::Util qw(forcomb vecsum);
use experimental 'refaliasing';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV >= 4;
usage: $0 [-examples] [-tests] [-verbose] [N1 N2 N3 N4...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N1 N2 N3 N4...
    list of at least four numbers

EOS


### Input and Output

say csq(@ARGV);


### Implementation

# Count Special Quadruplets:
# Loop over k-combinations of n, pick the corresponding values, check
# for the "special quadruplets" condition and count.
sub csq {
    \my @l = \@_;
	my $cnt;
    # Perl guarantees left-to-right evaluation of operator arguments, so
    # "pop" is performed before the slice @l[@_] is taken.
    forcomb {$cnt += $l[pop] == vecsum @l[@_]} @l, 4;
    $cnt;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is csq(1,2,3,6), 1, 'example 1';
        is csq(1,1,1,3,5), 4, 'example 2';
        is csq(3,3,6,4,5), 0, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is csq(0, 1, 2, 3, 6, 11, 20, 37, 68, 125), 7, 'strict sums';
	}

    done_testing;
    exit;
}
