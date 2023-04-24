#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    list of integers

EOS


### Input and Output

say for noble_int(@ARGV)->@*;


### Implementation

# There cannot be more than one Noble Integer in any list.
# Proof:
# Let N be a Noble Integer in the list L.
# Suppose there is another noble Integer M in this list.  We have either
# M < N or M > N.
# If M < N, then there are at least N integers greater than M in L
# because there are N integers greater than N in L.  This is a
# contradiction to M being Noble.
# Similarly, if M > N then there are at least M integers greater than N
# in L because there are M integers greater than M in L.  This is a
# contradiction to N being Noble.
# Therefore M cannot be noble.

# Get the sorted, unique numbers from the list, compare them with
# their index difference to the end of the list and return a match.
sub noble_int {
	my $l = long(@_)->uniq;
    $l->where($l == sequence(long, $l->dims)->(-1:0))->unpdl
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is noble_int(2, 1, 6, 3), [2], 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
