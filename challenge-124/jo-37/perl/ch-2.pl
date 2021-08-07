#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use warnings;
use List::Util qw(sum0 sum max reduce shuffle);
use List::MoreUtils qw(binsert firstidx bsearchidx);
use Math::Prime::Util qw(forcomb lastfor);
use Time::HiRes qw(gettimeofday tv_interval);
use Benchmark 'cmpthese';
use experimental qw(signatures postderef);

our ($tests, $examples, $benchmark, $scan, $approx);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-approx] [-scan] [-benchmark] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-approx=sec
    stop processing after sec seconds and return the best known
    approximation so far.  The actual processing time may be longer than
    specified because a node with a known minimal path has to be reached
    first.

-scan
    use the brute-force scan implementation

-benchmark
    benchmark the cbldm and the scan implementations

N...
    numbers to partition

EOS


### Input and Output

my ($diff, @p);
if ($scan) {
    # The scan approach is very inefficient for exact partitionings when
    # applied to sorted lists.  A large number of iterations is needed
    # until the two parts reach sums around halve the total sum.
    # Therefore shuffling the data.
    ($diff, @p) = tug_of_war(shuffle @ARGV);
    say "delta: $diff";
    say "Subset $_: ($p[$_]->@*)" for 0, 1;
} else {
    ($diff, @p) = run_cbldm(@ARGV);
    say "delta: $diff";
    say "Subset $_: ($p[$_]->@*)" for 0, 1;
}

exit unless $benchmark;
cmpthese(0, {
        tow => sub {tug_of_war(@ARGV)},
        cbldm => sub {run_cbldm(@ARGV)}
    });


### Implementation

# This is known as the "balanced partition problem", a variant of the
# partition problem.  Both belong to the class of NP-hard problems.
# Finding exact solutions is therefore expensive in the general case.
# There are several algorithms for the partition problem, particularly:
# - The "largest differencing method" (a.k.a. Karmarkar-Karp algorithm).
#   This algorithm is capable of finding a very good approximation in a
#   short time.
# - The "complete largest differencing method" (a.k.a. Complete
#   Karmarkar-Karp algorithm).  This is an extension to LDM that
#   improves the (initial) approximation until the minimum is found.  This
#   can be extremely fast if there exists an exact partitioning.  See
#   results below.
# Both algorithms can be extended to approximate or solve the balanced
# partition problem, culminating in Stephan Mertens' "complete balanced
# largest differencing method", which is implemented here.  See the
# arXiv paper for details.
#
# Some results for N successive cubic numbers starting with 1000000.
# Approximation done within 10 seconds, i.e.  -approx=10. A time below
# 10 s signifies a true solution.  N=23 is the largest size where a
# non-exact partitioning was found with certainty.
#
# N     mode            delta   time
# =     ====            =====   ====
# 22    approx          7       1.5s (true)
# 22    scan            7       3.7s
#
# 23    approx          7       2.5s (true)
# 23    scan            7       7.4s
#
# 24    approx          0       0.1s (true)
# 24    scan            0       1.8s
#
# 25    approx          0       0.2s (true)
# 25    scan            0       4.4s
#
# 26    approx          1       15.4s
# 26    scan            1       63.4s
#
# 27    approx          1       10.8s
# 27    scan            1       123.3s
#
# 28    approx          2       18.2s
# 28    scan            -       -
#
# 29    approx          0       8.4s (true)
# 29    scan            0       0.1s
#
# 30    approx          1       11.5s
# 30    scan            -       -
#
# 31    approx          1       17.ss
# 31    scan            -       -
#
# 32    approx          0       0.1s (true)
# 32    scan            0       35.6s
#
# 33    approx          0       0.1s (true)
# 33    scan            0       1.6s
#
# 34    approx          1       17.9s
# 34    scan            -       -
#
# 35    approx          1       17.8s
# 35    scan            -       -
#
# 36    approx          2       14.6s
# 36    scan            -       -
#
# 37    approx          0       14.5s (true)
# 37    scan            0       25.9s
#
# 38    approx          1       10.3s
# 38    scan            -       -
#
# 39    approx          1       13.6s
# 39    scan            -       -
#
# 40    approx          0       0.1s (true)
# 40    scan            0       24.1s
#
# 100   approx          6       14.8s
# 200   approx          48      10.3s
# 400   approx          0       0.1s (true)
# 800   approx          0       0.3s (true)
# 1600  approx          0       0.9s (true)
#
# In summary:
# - An exact partitioning may be found in a short time.
# - Approximated solutions are very good according to their absolute
#   delta which does not leave much room for improvements
# - The times to find exact partinionings using scan are pure chance due
#   to the shuffled data.
# - Not trying to find non-exact scan solutions for N > 33 due to the
#   expected running times.
# - For longer lists the probability for an exact partitioning grows and
#   these are found very quickly using CBLDM.
# 
# References:
# https://en.wikipedia.org/wiki/Partition_problem
# https://en.wikipedia.org/wiki/Largest_differencing_method
# arXiv:cs/9903011

our ($delta, $xmax, $mmax, $xsum, $msum, $n, $m, $start);

# Wrapper for the worker sub. Set up global variables, prepare input
# data and postprocess the result.  Returns the delta and both
# partitions.
sub run_cbldm (@n) {
    local $n = @n;
    local $m = @n % 2;
    local $delta = 'inf';
    local $xmax = max @n;
    local $xsum = sum @n;
    local $mmax = 1;
    local $msum = @n;
    local $start = [gettimeofday];

    my @p = cbldm([map {[$_, 1]} sort {$b <=> $a} @n]);

    ($delta, [map $_->[0], $p[0]->@*], [map $_->[0], $p[1]->@*]);
}

# Worker sub implementing Stephan Mertens' CBLDM.  This is not an
# "anytime algorithm" as proposed, as such algorithm would report all
# improved local solutions while running.
no warnings 'recursion';
sub cbldm ($x) {
    my @p;
    # At leaf nodes the current delta is known. 
    if (@$x == 1) {
        if (abs($x->[0][1]) == $m && $x->[0][0] < $delta) {
            $delta = $x->[0][0];
            return ([$x->[0]], []);
        }
    } else {
        # Prune the subtree if the maximum element minus the sum of the
        # rest is not smaller than the current delta. There cannot be a
        # better solution in such subtree.
        return if 2 * $xmax - $xsum >= $delta;
        # Similar for the cardinality: There is no valid partitioning if
        # the maximum cardinality minus the sum the rest is larger than
        # the required cardinality difference. Or if it cannot be
        # reached.
        return if 2 * $mmax - $msum > $m or $msum < $m;

        # Process left and right subtrees.  In the left subtree, the
        # first two elements are distributed onto both partitions,
        # whereas in the right subtree they go into the same partition.
        for my $sign (-1, 1) {
            # Take a copy of the data and pick the first two elements.
            my @x = @$x;
            my @pair = splice @x, 0, 2;

            # Build a composite element according to the current branch
            # (left/right) as difference or sum of the selected pair.
            my $xc = [$pair[0][0] + $sign * $pair[1][0],
                $pair[0][1] + $sign * $pair[1][1]];

            # Insert the composite element.  Divergent from the proposed
            # CBLDM, here is no switch to a "LDM phase".  The data
            # remains sorted from the beginning.
            binsert {$xc->[0] <=> $_->[0] || $xc->[1] <=> $_->[1]} $xc, @x;

            # Adjust the global variables.  As I didn't find a way to
            # calculate the new value for $mmax without iterating the
            # whole list, the other values may be recalculated as well.
            local ($xsum, $xmax, $msum, $mmax) = (reduce {
                    $a->[0] += $b->[0];
                    $a->[1] = max $a->[1], $b->[0];
                    $a->[2] += abs($b->[1]);
                    $a->[3] = max $a->[3], abs($b->[1]);
                    $a;
                } [0, '-inf', 0, '-inf'], @x)->@*;

            # Recurse into self, gathering a new minimal balanced
            # partitioning (if any).
            my @pn = __SUB__->(\@x);


            # The sub returns improved solutions only.
            if (@pn) {
                my ($idx, $p);
                # Locate the composite element in one of the partitions.
                for my $i (0, 1) {
                    $idx = bsearchidx {$_->[0] <=> $xc->[0] ||
                        $_->[1] <=> $xc->[1]} $pn[$i]->@*;
                    $p = $i;
                    last if $idx >= 0;
                }
                # Replace the composite element by its parts according
                # to the branch and partition.  Appending the parts
                # ensures an ascending order.
                splice $pn[$p]->@*, $idx, 1;
                if ($sign < 0) {
                    # Swap the pair if the composite element was found
                    # in the second partition. 
                    @pair = reverse @pair if $p;
                    push $pn[$_]->@*, $pair[$_] for 0, 1;
                } else {
                    # By construction, the first element is larger (or
                    # equal). Swap the pair.
                    push $pn[$p]->@*, reverse @pair;
                }
                # Record the current solution.
                @p = @pn;
            }

            # Stop if an exact solution has been detected or at the
            # current local minimum in approximation mode.
            return @p if $delta == 0 ||
                @p && defined $approx && tv_interval($start) > $approx;
        }
    }

    @p;
}

# For comparison I kept my first solution attempt: a brute force scan of
# all subsets having almost halve the cardinality.
sub tug_of_war (@a) {
    my $diff = 'inf';
    my @p;

    # Loop over all "halve subsets" of the given set of numbers.
    forcomb {
        # first subset:
        my @p0 = @a[@_];

        # second subset:
        # Take the remaining indices.  Performing delete on an array
        # slice despite this being "strongly discouraged".
        my @i = 0 .. $#a;
        delete @i[@_];
        my @p1 = @a[grep defined, @i];

        # Check for a new minimum difference.
        if ((my $d = abs(sum0(@p0) - sum0(@p1))) < $diff) {
            $diff = $d;
            @p = (\@p0, \@p1);
            # Stop on an exact partitioning.
            lastfor if $diff == 0;
        }
    } @a, int +(@a + 1) / 2;

    ($diff, @p);
}


### Examples and tests

sub run_tests {
    local $approx;
    SKIP: {
        skip "examples" unless $examples;

        # There is no unique solution for the examples.  Just checking
        # for correctness.
        my ($delta, $p1, $p2) = run_cbldm(qw(10 20 30 40 50 60 70 80 90 100));
        is $delta, 10, 'example 1, delta';
        is abs(sum(@$p1) - sum(@$p2)), $delta, 'example 1, sums';
        ok +(abs(@$p1 - @$p2) <= 1), 'example 1, cardinality';
        ($delta, $p1, $p2) = run_cbldm(qw(10 -15 20 30 -25 0 5 40 -5));
        is $delta, 0, 'example 2, delta';
        is abs(sum(@$p1) - sum(@$p2)), $delta, 'example 2, sums';
        ok +(abs(@$p1 - @$p2) <= 1), 'example 2, cardinality';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [run_cbldm(1)], [1, [1], []], 'single element';

        # 400 successive cubic numbers.
        my ($delta, $p1, $p2) = run_cbldm(map $_**3, 100 .. 499);
        is $delta, 0, 'cubes: delta';
        is abs(sum(@$p1) - sum(@$p2)), $delta, 'cubes: sums';
        ok +(abs(@$p1 - @$p2) <= 1), 'cubes: cardinality';

	}

    done_testing;
    exit;
}
