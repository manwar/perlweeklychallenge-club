#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(forcomb forperm);
use List::Util 'reduce';
use Benchmark 'cmpthese';
use experimental 'signatures';
use Data::Dump;

our ($examples, $verbose, $size, $max, $benchmark, $perm);
$max //= 10;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV || $size;
usage: $0 [-examples] [-verbose] [-size=N] [-max=M] [-benchmark] [-perm]
    [d11,d12,...,d1N ... dN1,dN2,...dNN]

-examples
    run the examples from the challenge
 
-verbose
    print final internal data structures

-size=N
    generate a random NxN distance matrix

-max=M
    use M as the maximum distance when generating a random matrix
    Default: 10

-benchmark
    run a benchmark comparing the Held-Karp implementation and a brute
    force trial

-perm
    use a brute force implementation instead of the Held-Karp algorithm

d11,d12,...,d1N ... dN1,dN2,...dNN
    build the distance matrix from the elements dij where columns are
    numerical values separated by comma and/or optional space and rows are
    the arguments to $0.

    The example may be specified as:
    $0 0,5,2,7 5,0,5,3 3,1,0,6 4,5,4,0
    or (combining some row formats):
    $0 '0  5  2  7' '5, 0, 5, 3' '3 1 0 6' 4,5,4,0


EOS


### Input and Output

my $dist;

# Use a random distance matrix.
if ($size && !@ARGV) {
    $dist = rand_dist($size, $max);
}

# Use the provided distance matrix.
if (@ARGV) {
    $dist = build_dist(@ARGV);
}

my ($cycle, $length) = $perm ? tsp_perm($dist) : tsp_held_karp($dist);
say "length=$length";
say "tour=(@$cycle)";

# Compare Held-Carp and brute force for the given parametrization.
if ($benchmark) {
    cmpthese(0, {
            held_karp => sub {tsp_held_karp($dist)},
            permute   => sub {tsp_perm($dist)},
        });
}

### Implementation

# Solving the asymmetric travelling salesman problem (aTSP) using the
# Held-Karp algorithm, see
# https://en.wikipedia.org/wiki/Held-Karp_algorithm.
# This algorithm provides an exact solution and becomes faster than a
# brute-force scan of all permutations for matrix sizes above 6x6.  The
# price is a rather high memory consumption.  This implementation is
# capable of solving an aTSP with a size of 20 in less than one minute
# but needs more than 1 GB of memory for this task.  Using GNU "time"
# instead of the shell builtin reports for -size=20:
#   42.48user 0.46system 0:43.01elapsed 99%CPU
#   (0avgtext+0avgdata 1236032maxresident)k
# 
# Cities are identified by a zero-based index.  The tour starts and ends
# in 0.
sub tsp_held_karp ($dist) {
    # $c{"@s"}{$c} is the minimum distance from 0 to $c visiting all
    # cities in @s.  The key for %c is a set. Here a set is represented
    # by a space separated, ordered list of its elements.
    my %c;
    # $p{"@s"}{$c} is the predecessor of $c when visiting all cities in
    # @s, i.e. the city in @s where the minimum $c{"@s"}{$c} is taken.
    my %p;
    # The values of %c are trivial for singletons @s = ($c).
    $c{$_}{$_} = $dist->[0][$_] for 1 .. $#$dist;
    # Loop over all subsets of at least two cities and omitting 0.
    for my $s (2 .. @$dist - 1) {
        forcomb {
            # Get the current subset of $s cities.
            my @s = @{[1 .. @$dist - 1]}[@_];
            # Loop over all the cities in the set.
            for my $k (@s) {
                # Remove the current city from the set.
                my @s_k = grep {$_ != $k} @s;
                # Dynamic programming:
                # The set @s_k (i.e. S\{k}) has one element less than @s
                # and thus all the minimum distances from 0 to any city
                # in @s_k via @s_k are already known.  This allows to
                # calculate the minimum distance from 0 to $k via all
                # cities in @s.  Keeping track of the actual predecessor
                # in @s_k.
                my $min = 'inf';
                my $p;
                for my $m (@s_k) {
                    my $cm = $c{"@s_k"}{$m} + $dist->[$m][$k];
                    if ($cm < $min) {
                        $min = $cm;
                        $p = $m;
                    }
                }
                $c{"@s"}{$k} = $min;
                $p{"@s"}{$k} = $p;
            }
        } @$dist - 1, $s;
    }
    # To complete the circle: for all cities in the full set of all
    # cities except the start find the minimum from the start to that
    # city plus the distance back to the start.
    my $min = 'inf';
    my $last;
    for my $k (1 .. $#$dist) {
        if ((my $m = $c{"@{[1 .. $#$dist]}"}{$k} + $dist->[$k][0]) < $min) {
            $min = $m;
            $last = $k;
        }
    }
    if ($verbose) {
        say "last: $last";
        say '%c:';
        dd \%c;
        say '%p:';
        dd \%p;
    }

    # So far this was almost straight from the wiki pseudo code.  Now
    # building the actual circle.  We only know the last city in the
    # tour yet but are able to backtrack using %p.
    my @circle = ($last, 0);
    # The set of all cities except 0.
    my @remainder = 1 .. $#$dist;
    while (@remainder > 1) {
        # Find the predecessor.
        my $pred = $p{"@remainder"}{$last};
        unshift @circle, $pred;
        # Remove the last city from the set and make its predecessor
        # the new last city.
        @remainder = grep {$_ != $last} @remainder;
        $last = $pred;
    }
    # Complete the circle with the start.
    unshift @circle, 0;
    (\@circle, $min);
}

# Brute force solution over all permutations of N - 1 cities.  This
# implementation is just a slight variation of the sub used in challenge
# 118.
#
# Benchmark for N=9:
#             Rate   permute held_karp
# permute   8.71/s        --      -96%
# held_karp  249/s     2756%        --
#
sub tsp_perm ($dist) {
    my @r = (1 .. $#$dist);
    my @circle;
    my $min = 'inf';
    forperm {
        my @tour = @r[@_];
        my $len;
        # Abuse "reduce" as a sliding window.
        reduce {
            $len += $dist->[$a][$b];
            $b;
        } 0, @tour, 0;
        if ($len < $min) {
            @circle = (0, @tour, 0);
            $min = $len;
        }
    } $#$dist;
    (\@circle, $min);
}

# Create a random distance matrix with given size and maximum distance.
sub rand_dist ($size, $max) {
    my @d;
    for my $i (0 .. $size - 1) {
        for my $j (0 .. $size - 1) {
            $d[$i][$j] = $i == $j ? 0 : 1 + int rand $max;
        }
    }
    dd \@d;

    \@d;
}

# Build a distance matrix from given rows/columns.
sub build_dist (@matrix) {
    my @d;
    push @d, [split /[ ,] */, $_] for @matrix;

    dd \@d if $verbose;

    \@d;
}


### Examples and tests

sub run_tests {
    is [tsp_held_karp([
            [0, 5, 2, 7],
            [5, 0, 5, 3],
            [3, 1, 0, 6],
            [4, 5, 4 ,0]])], [[0, 2, 1, 3, 0], 10], 'example';

    done_testing;
    exit;
}
