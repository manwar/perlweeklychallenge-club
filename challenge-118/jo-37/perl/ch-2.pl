#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Graph;
use List::Util 'reduce';
use Math::Prime::Util qw(forperm forsetproduct vecsum);
use experimental 'signatures';

our ($examples, $tests, $start);
$start //= 'a8';
@ARGV = qw(b1 a2 b2 b3 c4 e6) if $examples;

run_tests() if $tests;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-start=pos] [t1 ...]

-examples
    run the examples from the challenge

-tests
    run some tests

-start=pos
    use pos as the starting square for the knight. Default: a8

t1 ...
    positions of treasures on the board in chess notation (a1 ... h8)

Solving the example:
    $0 b1 a2 b2 b3 c4 e6
or simply:
    $0 -examples

Output is one line for each path from the starting square / previous
treasure square to the next treasure square.

EOS


### Input and Output

say join '->', @$_ for @{adventure_of_knight($start, @ARGV)};


### Implementation

# The task can be divided into four subtasks:
#
# 1) Build the knight's graph.  See
#    https://en.wikipedia.org/wiki/Knight%27s_graph
#
# 2) Find the shortest paths between the start and all treasure squares
#    within the knight's graph and build a weighted "treasure graph" out
#    of it.  See https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
#
# 3) Solve the travelling salesman problem in the "treasure graph".  See
#    https://en.wikipedia.org/wiki/Travelling_salesman_problem
#
# 4) Present the solution on the board.  This is probably the most
#    laborious part and has been left out here.

# Solve the task: subtasks 1) to 3).
sub adventure_of_knight ($start, @treasures) {
    min_hamiltonian($start,
        treasure_graph(knights_graph(), $start, @treasures));
}

# Build the knight's graph.
sub knights_graph {
    my $g = Graph::Undirected->new;
    forsetproduct {
        $g->add_edge($_[0] . $_[1], $_) for knights_moves(@_);
    } ['a' .. 'h'], [1 .. 8];

    $g;
}

# Find all possible knight's moves going two squares ascending.  No need
# to consider the opposite directions by symmetry. Use "character
# arithmetics" for the alphabetic column identifiers.
sub knights_moves (@sq) {
    map $_->[0] . $_->[1],
        grep $_->[0] ge 'a' && $_->[0] le 'h'
            && $_->[1] > 0 && $_->[1] <= 8,
        map [chr(ord($sq[0]) + $_->[0]), $sq[1] + $_->[1]], 
        [2, -1], [2, 1], [-1, 2], [1, 2];
}

# Find the shortest paths between the start square and all treasure
# squares in the knight's graph using Dijkstra's algorithm.  The result
# is a directed graph ("treasure graph") where the edges are tagged with
# the corresponding directed paths in the knight's graph and weighted
# with the paths' lengths.
sub treasure_graph ($g, $start, @treasures) {
    # Representation of the treasure graph as HoHoA:
    # origin, target, path.
    my %paths;

    # One-way from the start square.
    $paths{$start}{$_} = [$g->SP_Dijkstra($start, $_)] for @treasures;

    # Two-way between the treasure squares.
    while (my $this = shift @treasures) {
        for my $that (@treasures) {
            my @path = $g->SP_Dijkstra($this, $that);
            $paths{$this}{$that} = \@path;
            $paths{$that}{$this} = [reverse @path];
        }
    }

    \%paths;
}

# Find a minimum weighted Hamiltonian path in the treasure graph from
# the start square with the assigned path's length as weight.  By
# construction, every path from the starting square visiting any
# permutation of the treasure squares is valid and Hamiltonian.
# Adding directed, zero-weighted edges between all treasure squares and
# the start square would turn this into an equivalent asymmetric TSP -
# just to spot the complexity of the task.  Not attempting any
# optimizations.
sub min_hamiltonian ($start, $treasure) {
    my @treasures = grep {$_ ne $start} keys %$treasure;
    my ($minlen, $shortest) = 'inf';

    # Try all permutations of the treasure squares for the minimum path.
    forperm {
        my @paths;
        # Abuse "reduce" as a sliding window.
        reduce {
            push @paths, $treasure->{$a}{$b};
            $b;
        } $start, @treasures[@_];

        # Record a new minimum.
        if ((my $len = vecsum map scalar @$_, @paths) < $minlen) {
            $shortest = \@paths;
            $minlen = $len;
        }
    } @treasures;

    $shortest;
}


### Examples and tests

sub run_tests {
        
    is adventure_of_knight(qw(a1 d8 f7 h6 g4 e3 c2)),
        [[qw(a1 c2)], [qw(c2 e3)], [qw(e3 g4)], [qw(g4 h6)],
            [qw(h6 f7)], [qw(f7 d8)]], 'lined up';

    done_testing;
    exit;
}
