#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Math::Prime::Util qw(is_square formultiperm forsetproduct vecsum);
use List::Util 'all';
use List::MoreUtils 'slide';
use Benchmark 'cmpthese';
use experimental 'signatures';

our ($tests, $examples, $benchmark, $perm);

run_tests() if $tests || $examples || $benchmark;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-benchmark] [-perm] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-benchmark
    run benchmark tests

-perm
    use multi-permutation scan implementation

N...
    list of numbers

EOS


### Input and Output

say join ' ', map "(@$_)",
    ($perm ? squareful_perm(@ARGV) : squareful_gen(@ARGV))->@*;


### Implementation

# Before analyzing some solution approaches, let us consider two edge
# cases:
# A) @ints = (1, 8, 17, 32, 49, 72,...), see https://oeis.org/A077221
#    This array has two solutions (one forward and one backward) and it
#    has k! permutations.
# B) @ints = (2, 2, 2, 2,...)
#    This array has one solution (just itself) and it has one single
#    multi-permutation.
#
# A straightforward implementation would loop over all
# multi-permutations of the given list and record the squareful
# hits.  For case A) this would be k! loops to find two solutions -
# which is very inefficient.  In case B) there is a single loop
# revealing the single solution.
#
# A second thought: The list elements may be regarded as the vertices of
# an undirected graph.  Each vertex has a unique id and a value.
# Two vertices are connected by an edge if the sum of their values
# is a perfect square.  Then enumerate all Hamiltonian paths in the
# resulting graph.  Finding the two Hamiltonian paths in case A)
# should be easy.  However in case B) this approach would find k!
# Hamiltonian paths that are all identical within the scope of this
# task.
#
# Finally:
# Trying to merge the ideas behind the previous approaches.
# - Generate an "adjacency matrix" that defines the possible successors
#   of a given value.
# - Generate an availability counter for each unique value in the list.
# - Loop over all unique values from the list as the root node of a
#   "virtual tree".
# - Perform a depth-first search in each virtual tree.  Child nodes are
#   values that are both possible successors and have a positive
#   availability count.  At each leaf node having a depth equal to the
#   size of the list, record the path from the root node.
#
#  Case A) will loop over all k values as the root node.  All the
#  virtual trees are linear paths with only two of them reaching the
#  maximum depth.
#  Case B) consists of one single linear path.
#
sub squareful_gen {
    # Count each unique number and build a sorted list thereof.
    my %count;
    $count{$_}++ for @_;
    my @uniq = sort {$a <=> $b} keys %count;

    # Record all possible successors for a given value.
    my %succ;
    forsetproduct {
        push $succ{$_[0]}->@*, $_[1] if is_square vecsum @_;
    } \@uniq, \@uniq;


    # Loop over all unique root nodes.
    my @squareful;
    for my $root (@uniq) {
        # Remove the current value from the availability counter.
        $count{$root}--;
        # Find all squareful paths starting with the current root.
        _squareful(scalar @_, [$root], \%count, \%succ, \@squareful);
        # Reestablish the current value.
        $count{$root}++;
    }
    
    \@squareful;
}

# Depth-first traversal of a virtual tree having a maximum depth of
# $len, a path of $head from the root to the current node, an
# availability counter of $count, a successor map of $succ and a
# collection of solution paths in $squareful.
sub _squareful ($len, $head, $count, $succ, $squareful) {
    # Loop over all potential successors.
    for my $next ($succ->{$head->[-1]}->@*) {

        # Skip exhausted successors.
        next unless $count->{$next};

        # Extend the path from the root node.
        my @head = ($head->@*, $next);

        # Break recursion at full-depth leaf node.
        if (@head == $len) {
            push $squareful->@*, \@head;
            return;
        }

        # Recursive call starting at the next node.
        $count->{$next}--;
        _squareful($len, \@head, $count, $succ, $squareful);
        $count->{$next}++;
    }
}

# Brute force implementation scanning all multi-permutations of the
# given list.
sub squareful_perm {
    my @sq;
    formultiperm {
        push @sq, [@_] if all {is_square($_)} slide {$a + $b} @_;
    } \@_;

    \@sq;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is squareful_gen(1, 17, 8), [[1, 8, 17], [17, 8, 1]], 'example 1';
        is squareful_gen(2, 2, 2), [[2, 2, 2]], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is squareful_gen(10, 5, -1), [[5, -1, 10], [10, -1, 5]],
            'negative numbers';
        is squareful_perm(10, 5, -1), [[10, -1, 5], [5, -1, 10]],
            'alt negative numbers';
        is squareful_perm(1, 17, 8), [[1, 8, 17], [17, 8, 1]], 'alt example 1';
        is squareful_perm(2, 2, 2), [[2, 2, 2]], 'alt example 2';
	}

    SKIP: {
        skip "benchmark" unless $benchmark;

        my @list = qw(1 3 6 10 26 -1);
        say "[@$_]" for squareful_gen(@list)->@*;

        cmpthese(0, {
                perm => sub {squareful_perm(@list)},
                gen  => sub {squareful_gen(@list)},
            });
    }

    done_testing;
    exit;
}
