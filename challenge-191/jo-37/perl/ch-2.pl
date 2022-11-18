#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use Math::Prime::Util qw(forsetproduct forcomb);
use experimental 'signatures';

our ($tests, $examples, $ryser);

run_tests() if $tests || $examples;	# does not return

my $permanent = $ryser ? \&ryser : \&bbfg;

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-ryser] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-ryser
    Use an implementation of the Ryser formula instead of
    Balasubramanian-Bax-Franklin-Glynn.

N
    length of cute lists to be counted.

EOS


### Input and Output

say count_cute(shift, $permanent);


### Implementation

# First approach:
# Loop over permutations, check for cute lists and count these.  This
# looks kind of insane as 15! = 1307674368000.  Not even tried it.
# 
# Second approach:
# Loop over the possible values at a given position and then recurse to
# the next position with a reduced list of values.  This works, but
# isn't really satisfying.  Dropped it.
#
# Third approach:
# Do not count the number of cute lists but calculate it instead.  A
# cute list may be regarded as a complete matching between the numbers
# from 1 to N and the N slots in the list.  A number is permitted in a
# slot, if the corresponding element in the adjacency matrix is one.
# The number of perfect matchings in an unweighted bipartite graph
# defined by its adjacency matrix A equals the permanent of A. See [2].
# For a cute list the adjacency matrix A is defined by:
#   a(i,j) = 1 if i is divisible by j or j is divisible by i and
#   a(i,j) = 0 otherwise.
# Calculating the permanent of a matrix is rather expensive.  However,
# utilizing the Balasubramanian-Bax-Franklin-Glynn formula (see [3]) the
# computation for N>15 becomes possible.  The running time roughly
# doubles when N is incremented by 1.  Here N=20 takes about 10 s and
# N=28 takes about 40 min.  Beyond that the given PDL implementation
# runs into longlong overflows on the "cute" adjacency matrix and will
# produce false results at some point.
#
# NB: Tried some different ways of implementing the better known Ryser
# formula.  None was able to keep up with B-B-F-G.  See below for the
# best of these attempts (that has more than twice the running time
# compared to the B-B-F-G implementation).
#
# NB2: What a shame! wxMaxima finds the solution for N=28 in 5 min.
#
# References:
# [1] http://oeis.org/A320843
# [2] https://en.wikipedia.org/wiki/Permanent_(mathematics)
# [3] https://en.wikipedia.org/wiki/Computing_the_permanent

sub count_cute ($n, $permanent) {
    # Build the upper right triangle of the adjacency matrix A for a
    # "cute list" of size N.
    my $a = !((xvals(long, $n) + 1) % (yvals(long, 1, $n) + 1));
    # Build the full adjacency matrix utilizing its symmetry.
    $a->inplace->or2($a->xchg(0, 1), 0);

    # Find the number of cute lists.
    $permanent->($a);
}

# Calculate the permanent of a square matrix using the
# Balasubramanian-Bax-Franklin-Glynn formula.
sub bbfg ($a) {
    my $n = $a->dim(1);
    # Allocate the vector δ.  As the summands will become very large,
    # calculations for N > 14 need to be done on longlong types coming
    # in here.
    my $d = zeroes longlong, $n;
    my $dr = $d->get_dataref;
    my $perm = longlong 0;
    # Straightforward implementation of the
    # Balasubramanian-Bax-Franklin-Glynn formula, see [3]:
    forsetproduct {
        # Set d to a single "1" followed by all of {-1, 1}**(N-1)
        # Manipulating d's internal data to gain maximum speed.
        $$dr = pack 'q*', 1, @_;
        $d->upd_data;
        # The outer sum:
        $perm = $perm + prodover($d) * prodover($d x $a);
    } ([-1, 1]) x ($n - 1);

    # The permanent of A:
    $perm->sclr / 2 ** ($n - 1);
}

# Calculate the permanent of a square matrix using the Ryser formula.
sub ryser ($a) {
    # Operate on longlong type.
    $a = convert $a, longlong;
    my $n = $a->dim(0);
    my $minus_one = long -1;
    my $perm = longlong 0;
    # Straightforward implementation of the Ryser formula, see [3].
    # Loop over all subsets of {0,...,N-1}
    forcomb {
        $perm = $perm + $minus_one**@_ * prodover sumover $a->dice(\@_);
    } $n;

    # The permanent of A:
    (-1)**$n * $perm->sclr;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_cute(2, \&bbfg), 2, 'Example';
    }

    SKIP: {
        skip "tests" unless $tests;

        # See [1].
        is count_cute(10, \&bbfg),  700,   'N=10 bbfg';
        is count_cute(10, \&ryser), 700,   'N=10 ryser';
        is count_cute(15, \&bbfg),  24679, 'Last from task';
        is count_cute(16, \&bbfg),  87328, 'From A320843';
	}

    done_testing;
    exit;
}
