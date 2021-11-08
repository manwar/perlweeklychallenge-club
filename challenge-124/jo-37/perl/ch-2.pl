#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use warnings;
use List::Util qw(sum0 sum max reduce shuffle);
use List::MoreUtils qw(binsert firstidx bsearchidx);
use Math::Prime::Util qw(forcomb lastfor);
use Time::HiRes qw(gettimeofday tv_interval);
use experimental qw(signatures postderef);

our ($tests, $examples, $scan, $approx);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-approx=sec] [-scan] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-approx=sec
    stop processing after sec seconds and return the best known
    approximation so far.  Use -approx=0 to show the very first result.

-scan
    use the brute-force scan implementation

N...
    numbers to partition

EOS


### Input and Output

my ($diff, @p);
if ($scan) {
    # The scan approach is very inefficient for an exact partitioning or
    # approximations when applied to sorted lists.  A large number of
    # iterations is needed until the two parts reach sums around halve
    # the total sum.  Therefore shuffling the list. (Test2::V0 seeds the
    # current date, so results are consistent within the same day.)
    ($diff, @p) = tug_of_war(shuffle @ARGV);
    say "delta: $diff";
    say "Subset $_: ($p[$_]->@*)" for 0, 1;
} else {
    ($diff, @p) = run_cbldm(@ARGV);
    say "delta: $diff";
    say "Subset $_: ($p[$_]->@*)" for 0, 1;
}


### Implementation

# This is known as the "balanced partition problem", a variant of the
# partition problem.  Both belong to the class of NP-hard problems.
# Finding proper solutions is therefore expensive in the general case.
# There are several algorithms for the partition problem, particularly:
# - The "largest differencing method" (a.k.a. Karmarkar-Karp algorithm).
#   This algorithm is capable of finding a very good approximation in a
#   short time.
# - The "complete largest differencing method" (a.k.a. Complete
#   Karmarkar-Karp algorithm).  This is an extension to LDM that
#   improves the (initial) approximation until the minimum is found.  This
#   can be extremely fast if there exists an exact partitioning and it
#   provides very good estimates when used as an "anytime algorithm".  See
#   results below.
# Both algorithms can be extended to approximate or solve the balanced
# partition problem, culminating in Stephan Mertens' "complete balanced
# largest differencing method", which is implemented here.  See the
# arXiv paper for details.
#
# Distinguishing between a "proper solution" that represents a global
# minimum and an "exact partitioning" where both subsets have equal
# sums.  Every exact partitioning is a proper solution.
#
# Here are some approximation results for N successive cubic numbers
# starting with 1000000 and limited to a maximum run time of 20 s.  If
# an approximation can be identified as a global minimum, it is marked
# as "proper".  Delta is the difference between the partitions' sums.
#
# N     mode        delta   time
# =     ====        =====   ====
# 20    cbldm       6       0.6s (proper)
# 20    scan        6       1.3s (proper)
#
# 21    cbldm       4       0.9s (proper)
# 21    scan        4       2.6s (proper)
#
# 22    cbldm       7       1.8s (proper)
# 22    scan        7       5.1s (proper)
#
# 23    cbldm       7       3.2s (proper)
# 23    scan        7       10.1s (proper)
#
# 24    cbldm       0       0.1s (proper)
# 24    scan        0       2.5s (proper)
#
# 25    cbldm       0       0.2s (proper)
# 25    scan        0       6.0s (proper)
#
# 26    cbldm       1       19.7s (proper)
# 26    scan        1       20.1s
#
# 27    cbldm       1       20.1s
# 27    scan        5       20.1s
#
# 28    cbldm       2       20.1s
# 28    scan        2       20.1s
#
# 29    cbldm       0       10.5s (proper)
# 29    scan        0       0.8s (proper)
#
# 30    cbldm       1       20.1s
# 30    scan        3       20.1s
#
# 31    cbldm       1       20.1s
# 31    scan        1       20.1s
#
# 32    cbldm       0       0.1s (proper)
# 32    scan        2       20.1s
#
# 33    cbldm       0       0.2s (proper)
# 33    scan        0       1.9s (proper)
#
#
# 100   cbldm       6       20.1s
# 100   scan        6       20.1s
#
# 200   cbldm       48      20.1s
# 200   scan        6985248 20.1s
#
# 400   cbldm       0       0.1s (proper)
# 400   scan        1093681818  20.1s
#
# 800   cbldm       0       0.3s (proper)
# 800   scan        13038516378 20.1s
#
# 1600  cbldm       0       0.9s (proper)
# 1600  scan        7565594650  20.1s
#
# In summary:
# - In many cases CBLDM is capable of finding an exact partitioning in a
#   short time.
# - Many approximated solutions are very good according to their
#   absolute delta, which does not leave much room for improvements.
#   (Actually, all shown CBLDM approximations for N <= 33 are proper.)
# - With the scan implementation, time-limited results and the time
#   needed to find an exact partitioning are pure chance due to the
#   shuffled list.
# - In general, trying to find proper solutions for larger lists doesn't
#   seem reasonable.
# - For longer lists the probability for an exact partitioning grows and
#   these may be found very quickly using CBLDM.
# - For longer lists a scan approximation becomes useless and the
#   strength of CBLDM emerges. For N=200,400,800,1600 the very first
#   result is already final. (Use -approx=0)
# 
# References:
# https://en.wikipedia.org/wiki/Partition_problem
# https://en.wikipedia.org/wiki/Largest_differencing_method
# arXiv:cs/9903011

our ($delta, $xmax, $mmax, $xsum, $msum, $n, $m, $start);

# Wrapper for the worker sub. Set up global variables, prepare input
# data and post-process the result.  Returns the delta and both
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
# improved local solutions while running.  For the sake of simplicity,
# here the processing will be aborted after a given running time
# instead.
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
            # whole list, the other values are recalculated as well.
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


            # The sub returns improved solutions only. Backtrack.
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

            # Stop if an exact partitioning has been detected or there
            # exists a local minimum and the running time is exhausted.
            return @p if $delta == 0 || defined $approx &&
                ($delta < 'inf') && tv_interval($start) > $approx;
        }
    }

    @p;
}

# My first solution attempt: a brute force scan of all subsets having
# (almost) halve the cardinality.  For a better comparison to CBLDM a
# time limit was added.
sub tug_of_war (@a) {
    my $diff = 'inf';
    my @p;
    my $start = [gettimeofday];

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
        # Time exhausted.
        lastfor if defined $approx && tv_interval($start) > $approx;
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
