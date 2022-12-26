#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples, $first);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-first] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-first
    print only the first found triple (as specified in the task)

N...
    list of numbers to be searched for 132-subsequences

EOS


### Input and Output

if ($first) {
    my $f = find_132(@ARGV);
    say $f->slice('X,(0)') unless $f->isempty;
} else {
    say find_132(@ARGV);
}


### Implementation

# Looping over three indices and comparing number pairs would be
# straightforward.  Following a somewhat funnier approach.
#
# Considering transitions from one element of the list L to another
# according to some constraints defined by a matrix A.  The transition
# from element at index i to the element at index j is allowed, if the
# matrix element a(i,j) is nonzero.  Given there is a second transition
# from an element at index j to an element at index k defined by a
# matrix B in the same manner, then a transition from index i to index k
# via any index j is defined by the matrix product B A.  Similarly a
# third transition from index k to index l defined by C defines a
# transition from i to l as described by C B A.  Here in our task the
# transition from l to k shall return back to the starting index i.
# Thus all possible starting indices can be found from the nonzero
# elements of the diagonal in the matrix product C B A.
#
# The possible back transitions from one index to its predecessor is
# given by the transpose of the forward transition matrix.
#
# The three (forward) transitions are:
# 1) i -> j is allowed if i < j and L(i) < L(j)
# 2) j -> k is allowed if j < k and L(j) > L(k)
# 3) k -> l is allowed if k > l and L(k) > L(l)
#
# The index order can be specified by an (upper or lower) triangular
# matrix of zeroes and ones and the element order by the matrix of
# pairwise comparisons of all list elements with either 1 or -1 replaced
# by zero.  The logical AND between index and element relations can be
# achieved with an element-wise multiplication of the triangular and the
# clipped comparison matrix.
#
# Steps to solve the task:
# - Construct the matrix containing the comparison results between all
#   number pairs.
# - Construct a lower triangle matrix having the same dimensions.
# - Construct three transition matrices from the first element to the
#   second, from the second to the third and from the third back to the
#   first as described above.
#
# At this stage we are able to construct solutions instead of only
# searching for them and thus we'll not restrict the task to find the
# first 132-triple:
#
# Looping over all possible first indices as given by the nonzero
# elements of the diagonal of the three transition matrices' product.
#
# The second indices for a given first index must be successors of the
# first index as well as pre-predecessors thereof.
#
# Finally, the third indices for a given first and second index must be
# successors of the second index and predecessors of the first.

sub find_132 {
	my $l = long @_;

    # Construct the comparison matrix:
    my $comp = $l <=> $l->dummy(0);

    # Construct a lower triangular matrix indicating index order:
    my $t = sequence(long, $l->dim(0)) < sequence(long, $l->dim(0))->dummy(0);

    # Transition from the first to the second element:
    # The second must be larger than the first and have a larger index.
    my $a1 = -$comp->hclip(0) * $t;

    # Transition from the second to the third element:
    # The third must be smaller than the second and have a larger index.
    my $a2 = $comp->lclip(0) * $t;

    # Transition from the third to the fourth element:
    # The fourth must be smaller than the third and have a smaller index
    my $a3 = $comp->lclip(0) * $t->xchg(0, 1);

    # Collect solution indices:
    my $triples = null;

    # Loop over all possible first indices:
    for my $i (which(($a3 x $a2 x $a1)->diagonal(0, 1))->dog) {
        # Create a unit vector pointing in $i direction:
        my $ui = identity($l)->dice($i);
        # Loop over all second indices that are successors and
        # pre-predecessor of the current first index.
        for my $j (which(
                ($a1 x $ui) * ($a2->xchg(0, 1) x $a3->xchg(0, 1) x $ui)
            )->dog) {
            # Create a unit vector pointing in $j direction:
            my $uj = identity($l)->dice($j);
            # Loop over all third indices that are successors of the
            # current second index and predecessors of the current first
            # index.
            for my $k (which(($a2 x $uj) * ($a3->xchg(0, 1) x $ui))->dog) {
                # Record an 132 index triple.
                $triples = $triples->glue(1, indx($i, $j, $k)->dummy(1));
            }
        }
    }

    # Get sublists from index triples.
    $l->index($triples);
}


### Examples and tests

sub fst {
    shift->unpdl->[0];
}

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is find_132(3, 1, 4, 2)->unpdl->[0], [1, 4, 2], 'example 1';
        ok find_132(1, 2, 3, 4)->isempty, 'example 2';
        is find_132(1, 3, 2, 4, 6, 5)->unpdl->[0], [1, 3, 2], 'example 3';
        is find_132(1, 3, 4, 2)->unpdl->[0], [1, 3, 2], 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;
        is find_132(2, 1, 3, 2)->unpdl, [[1, 3, 2]], 'large prefix';
        is find_132(1, 2, 3, 2)->unpdl, [[1, 3, 2]], 'small successor';
        is find_132(1, 3, 3, 2)->unpdl->[0], [1, 3, 2], 'repeated successor';
        is find_132(1, 3, 1, 2)->unpdl, [[1, 3, 2]], 'small third';
        is find_132(5, 1, 2, 3, 1, 2, 4, 6, 5)->unpdl,
            [[1, 3, 2], [1, 6, 5], [2, 6, 5], [3, 6, 5], [1, 6, 5],
                [2, 6, 5], [4, 6, 5]], 'all in one';
        ok find_132(2, 3, 2, 3, 1, 2, 1, 2, 3)->isempty, 'none';
	}

    done_testing;
    exit;
}
