#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental qw(signatures postderef);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    length of cute lists to be counted.

EOS


### Input and Output

say count_cute(shift);


### Implementation

# Do not count the number of cute lists but calculate it instead.  A
# cute list may be regarded as a complete matching between the numbers
# from 1 to N and the N slots in the list.  A number is permitted in a
# slot, if the corresponding element in the adjacency matrix is one.
# The number of perfect matchings in an unweighted bipartite graph
# defined by its adjacency matrix A equals the permanent of A. See [2].
# For a cute list the adjacency matrix A is defined by:
#   a(i,j) = 1 if i is divisible by j or j is divisible by i and
#   a(i,j) = 0 otherwise.
# Calculating the permanent of a matrix is rather expensive.
# Though the results from the implementation in ch-2.pl are not too bad,
# they fall behind Maxima's "permanent" function.  Thus trying harder.
#
# The Maxima manual states the permanent would be implemented using the
# "Johnson-Gentleman tree minor algorithm".  Some web research revealed
# an article by Gentleman and Johnson [4] about the calculation of
# determinants using a non-recursive unbalanced tree approach.  This
# priciple may be trivially applied to permanents, too.  The article is
# mainly about the complexity of such a class of algorithms and does not
# go into details about an implementation.
#
# Tried to implement the idea described in the article and to optimize
# it as far as possible.  Almost could catch up with Maxima.  Need
# 6:15 min / 3.9 GB for N=28 compared to Maxima's 5.06 min / 1.9 GB.
# While Maxima crashes with N=29, this implementation solves N=30 in
# 20:45 min / 9.8 GB.
#
# References:
# [1] http://oeis.org/A320843
# [2] https://en.wikipedia.org/wiki/Permanent_(mathematics)
# [3] https://en.wikipedia.org/wiki/Computing_the_permanent
# [4] W. M. Gentleman, S. C. Johnson: The Evaluation of Determinants by
#     Expansion by Minors and the General Problem of Substitution, Math
#     Comp, Vol. 28, Nr. 126 (1974)
#     https://www.ams.org/journals/mcom/1974-28-126/S0025-5718-1974-0373369-7/S0025-5718-1974-0373369-7.pdf

sub count_cute ($n) {
    # Build the adjacency matrix A for a "cute list" of size N.
    my @a;
    for my $i (0 .. $n - 1) {
        for my $k (0 .. $n - 1) {
            my $v = 0 + (!(($i + 1) % ($k + 1)) || !(($k + 1) % ($i + 1)));
            $a[$i][$k] = $v;
        }
    }

    # Find the number of cute lists.
    permanent_01(\@a);
}

# An attempt to implement the "Johnson-Gentleman tree minor algorithm":
# This is a non-recursive approach that avoids the re-examination of
# minors appearing in recursive approaches.  It does not split the task
# of calculating a determinant/permanent into smaller tasks but instead
# builds the whole result by extending from single elements.  This takes
# a lot of memory for larger matrices.  Restricting to matrices having
# only zeroes and ones as elements.
#
sub permanent_01 ($a) {
    my $node;
    my $last = $#$a;
    my $sel;

    # Nodes are key-value pairs where the keys are integers with bits
    # set for the selected rows forming a minor matrix and the
    # corresponding sub-permanent as values.

    # Build the first node, consisting of the non-zero elements of the
    # first column.
    for my $i (0 .. $last) {
        $node->{1 << $i} = 1 if $a->[0][$i];
    }

    # Loop over the remaining columns.
    for my $i (1 .. $last) {
        my $next;
        # Loop over all minors of the previous node. These have a size
        # of $i x $i
        for my $minor (keys %$node) {
            # Loop over all rows.  Process only nonzero elements.  Get
            # the selector for the current row and check if it is
            # already part of the current minor or add the minor's part
            # to the next larger minor extended by the current row
            # otherwise.  Avoiding any multiplications here as all
            # elements are zero or one - though the impact is very low.
            $a->[$i][$_] && (($sel = 1 << $_) & $minor && next ||
#            ($next->{$minor | $sel} += $a->[$i][$_] * $node->{$minor}))
            ($next->{$minor | $sel} += $node->{$minor}))
            for 0 .. $last;
        }
        $node = $next;
    }
    
    # At the end, there is only one value left - the permanent of the
    # whole matrix.
    (values %$node)[0];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_cute(2), 2, 'Example';
    }

    SKIP: {
        skip "tests" unless $tests;

        # See [1].
        is count_cute(10),  700,   'N=10';
        is count_cute(15),  24679, 'Last from task';
        is count_cute(20),  1939684, 'N=20 from A320843';
	}

    done_testing;
    exit;
}
