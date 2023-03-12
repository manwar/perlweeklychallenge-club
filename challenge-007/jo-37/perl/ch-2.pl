#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use autodie;
use List::MoreUtils qw(zip6);
use List::Util qw(sum);
use Graph::Undirected;
use experimental qw(signatures);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 3;
usage: $0 [-examples] [-tests] [WORD1 WORD2 FILE]

-examples
    run the examples from the challenge
 
-tests
    run some tests

WORD1 WORD2
    begin and end of a word ladder

FILE
    name of a file containing a list of equal sized words.  Use '-' for STDIN

EOS


### Input and Output

main: {
    my ($x, $y) = splice(@ARGV, 0, 2);
    say "(@{[ladder(\*ARGV, $x, $y)]})";
}


### Implementation

# Build a graph from the words in file handle $fh.  Each word represents
# one vertex.  Two vertices are connected if the words are neighbors
# (see below).  In the resulting graph find the shortest path between
# two given words $x and $y.
sub ladder ($fh, $x, $y) {
    my $g = Graph::Undirected->new;
    # Add vertices.
    while (<$fh>) {
        chomp;
        $g->add_vertex(lc $_);
    }
    # Loop over vertex pairs and add an edge for each neighboring pair.
    my @vertices = $g->vertices;
    for my $i (1 .. $#vertices - 1) {
        my $vi = $vertices[$i];
        for my $k ($i + 1 .. $#vertices) {
            my $vk = $vertices[$k];
            $g->add_edge($vi, $vk) if neighbors($vi, $vk);
        }
    }
    # Find the shortest path between $x and $y.
    $g->SP_Dijkstra($x, $y);
}

# Test if two words are "neighbors", i.e. they differ in exactly one
# character position.
sub neighbors ($x, $y) {
    # Circumvent zip6's prototype.
    1 == sum map $_->[0] ne $_->[1], &zip6([split //, $x], [split //, $y]) 
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        open my $words, '-|', q{egrep -i -e '^[a-z]{4}$' /usr/share/dict/words};
        is [ladder($words, 'cold', 'warm')], [qw(cold cord card ward warm)],
            'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
