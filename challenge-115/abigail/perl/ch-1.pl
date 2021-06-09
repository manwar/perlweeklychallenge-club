#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# I usually don't use stuff from CPAN which implements most or
# all of the challenge, but I do make an exception for modules
# I authored myself. Even if it's from 1998.
#
use Algorithm::Graphs::TransitiveClosure qw [floyd_warshall];

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

#
# The challenge description doesn't make it clear whether we're
# looking for a cycle consisting of all strings, or whether
# any loop is sufficient. As is often the case, the examples aren't helpful,
# as they either contain cycles with all strings, or without any cycles.
#
# We will output 1 if there is *any* cycle. Including looping back to
# itself. So, if the input contains the word "eye", we will return 1.
#
# See https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-115-1.html
# for details on how the algorithm in the module works.
#

while (<>) {
    #
    # Read in the words, store them bucketed by first letter,
    # and in a list. We're assuming each set is on a separate
    # line separated by white space.
    #
    # We will create a (directed) graph from the strings in a
    # set; each string gives us an edge from the first letter
    # of the string to the last letter. (Hence, the nodes in
    # this graph are the first and last letters of the strings).
    #
    my $graph;
    foreach my $node (split) {
        $$graph {substr $node, 0, 1} {substr $node, -1} = 1;
    }

    #
    # Calculate the transitive closure.
    #
    floyd_warshall $graph;

    #
    # We do have a loop iff we have a node which can reach itself.
    #
    say grep ({$$graph {$_} {$_}} keys %$graph) ? 1 : 0;
}

