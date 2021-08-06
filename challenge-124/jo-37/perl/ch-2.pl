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
    # The scan approach is very inefficient when applied to sorted
    # lists.  A large number of iterations is needed until the two parts
    # reach sums around halve the total sum.  Therefore shuffling the
    # data.
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
# Some results for N successive square numbers starting with 1000000.
# Approximation done within 60 and 5 wall clock seconds or "first
# found", i.e.  -approx=0. A time below 60 s signifies a true solution.
# N=29 is the largest size where a non-exact partitioning could be found
# with certainty.  The exact partitioning result for N=28 using "scan"
# requires shuffled input data.
#
# N     mode            delta   time
# =     ====            =====   ====
# 26    approx=60       1017    19.3s (proven)
# 26    approx=5        1261    5.1s
# 26    approx=0        1977    0.1s
# 26    scan            1017    61.3s
#
# 28    approx=60       0       0.1s
# 28    approx=0        4       0.1s
# 28    scan            0       0.1s
#
# 29    proven          602316  134.2s
# 29    approx=60       655330  76.8s
# 29    approx=5        749020  7.1s
# 29    approx=0        971594  0.1s
#
# 36    approx=60       0       0.2s
# 36    approx=0        4       0.1s
#
# 38    approx=60       957     71.4s
# 38    approx=5        1377    5.1s
# 38    approx=0        1965    0.1s
#
# 64    approx=60       0       0.1s
# 64    approx=0        0       0.1s
#
# 128   approx=60       0       0.1s
# 128   approx=0        0       0.1s
#
# 256   approx=60       0       0.1s
# 256   approx=0        0       0.1s
#
# 512   approx=60       0       0.2s
# 512   approx=0        0       0.2s
#
# 1024  approx=60       0       0.4s
# 1024  approx=0        0       0.4s
#
# 2048  approx=60       0       1.3s
# 2048  approx=0        0       1.3s
#
# In summary:
# - An exact partitioning may be proven in a short time.
# - Approximated solutions are not far from optimum even for short
#   running times. (As far as the optimum is known.)
# - The first found local minimum is already a good approximation and an
#   exact partitioning might be detected with it.
# - A practical usage is an approximation with some reasonable running
#   time limit.
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

        # 256 successive square numbers.
        my ($delta, $p1, $p2) = run_cbldm(map $_**2, 1000 .. 1255);
        is $delta, 0, 'squares: delta';
        is abs(sum(@$p1) - sum(@$p2)), $delta, 'squares: sums';
        ok +(abs(@$p1 - @$p2) <= 1), 'squares: cardinality';

	}

    done_testing;
    exit;
}
