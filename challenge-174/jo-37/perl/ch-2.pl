#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(permtonum numtoperm);
use experimental qw(signatures postderef);

our ($tests, $examples, $verbose, $rank);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-rank=K] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-rank=K
    find the permutation of rank K.  Without this option, the rank of
    the given list as a permutation is calculated.

N...
    List of integers without duplicates.  Find its rank or the
    permutation of rank k thereof if -rank=K is specified.

EOS


### Input and Output

say defined($rank) ? "@{rank2perm($rank, \@ARGV)}" : perm2rank(\@ARGV);


### Implementation

# The task states: "You are given a list of integers with no
# duplicates."
# This is clearly different from a permutation of the numbers from 0 to
# N.  Thus the list *as is* must not be interpreted as a permutation.

# Take the given list as a permutation of sortable "items" (here:
# integers).  Build a map from each item to its position in the sorted
# list and transform the list of items into a list of the corresponding
# indices.  The resulting list represents a valid permutation having a
# rank as provided by "permtonum".
sub perm2rank ($n) {
    (\my %s)->@{sort {$a <=> $b} @$n} = (0 .. $#$n);

    permtonum([@s{@$n}]);
}

# For the reverse operation the order of the given items is irrelevant
# as rank k=0 always represents the ordered list and all other ranks are
# derived from this starting point.  Find the permutation
# corresponding to rank k and use it as array indices in the sorted
# list.
sub rank2perm ($k, $n) {
    [(sort {$a <=> $b} @$n)[numtoperm(@$n, $k)]];
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is perm2rank([1, 0, 2]), 2, 'example 1';
        is rank2perm(1, [0, 1, 2]), [0, 2, 1], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is perm2rank([100, 1, 10]), 4, 'perm2rank';
        is rank2perm(4, [10, 100, 1]), [100, 1, 10], 'rank2perm';
	}

    done_testing;
    exit;
}
