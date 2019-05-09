#!/usr/bin/env perl

# A word ladder is a sequence of words [w0, w1, …, wn] such that each word wi in
# the sequence is obtained by changing a single character in the word wi-1. All
# words in the ladder must be valid English words.

use 5.026;
use strict;
use autodie;
use warnings;
use List::Util qw(reduce uniq);
use Path::Tiny;

# Implements Dijkstra's Algorith as described in
# https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode

sub first_shortest_ladder {
    my ($source, $target, $wordlist) = @_;

    # Build an adjacency graph from $wordlist

    my (%graph, %dist, %prev);

    my $length = length $source;
    for my $i (0 .. @$wordlist-2) {
        my $word_i = $wordlist->[$i];
        foreach my $word_j (@{$wordlist}[$i+1 .. @$wordlist-1]) {
            my $distance = 0;
            for (my $k = $length; $k >= 0; --$k) {
                $distance += 1 if substr($word_i, $k, 1) ne substr($word_j, $k, 1);
            }
            if ($distance == 1) {
                $graph{$word_i}{$word_j} = undef;
                $graph{$word_j}{$word_i} = undef;
            }
        }
        $dist{$word_i} = @$wordlist + 1; # infinity
        $prev{$word_i} = undef;
    }

    $dist{$source} = 0;

    while (%graph) {
        my $u = reduce {$dist{$a} < $dist{$b} ? $a : $b} keys %graph;

        my $neighbors = delete $graph{$u};

        last if $u eq $target;      # found a shortest path to $target

        foreach my $v (grep {exists $graph{$_}} keys %$neighbors) {
            my $alt = $dist{$u} + 1;
            if ($alt < $dist{$v}) {
                $dist{$v} = $alt;
                $prev{$v} = $u;
            }
        }
    }

    # Return an empty list if no path was found to $target
    return if exists $graph{$target};

    my @path = ($target);

    for (my $u = $target; $prev{$u}; $u = $prev{$u}) {
        unshift @path, $prev{$u};
    }

    return @path;
}

@ARGV == 2 or die "Usage: $0 FROM TO\n";

my ($source, $target) = map {lc} @ARGV;

my $length = length $source;

my @words =
    uniq
    sort
    map {lc}
    grep {length == $length}
    path('/usr/share/dict/words')->lines({chomp => 1});

my @ladder = first_shortest_ladder($source, $target, \@words);

say join "\n", @ladder;
