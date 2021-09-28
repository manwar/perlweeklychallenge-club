#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# And once again, a stupid challenge about a tree with no
# fucking clue about how the input is structured. For instance,
# a star with 27 elements, how on earth is this going to presented?
# Using examples of tiny, sparse, binary trees is not at all helpful.
#
# We're not going to even attempt to think how the input will be
# structered. We'll just assume magic, and the tree to be there
# once the program starts.
#
# This challenge is just a shortest path algorithm, from algorithms 101.
# The fact the graph is a tree provides us with little benefits (for 
# some representations of a tree, we can skip a bit of bookkeepping, 
# but this is such a standard algorithm, why bother?)
#
# We will be assuming that the numbers in the examples are just labels
# of the nodes, (instead of actual values); therefore, we can treat the
# numbers as unique numbers, and we don't have to deal with duplicates.
# The root node will always have label 1.
# 
# The graph will be representated as hash: the keys are the labels of
# the nodes, the values are a list of neigbhours of the nodes. (Using
# magic to read in the data).
#
# We also assume that "You are given a tree and a node of the given tree."
# is leading, and the examples are misleading, as the examples give
# multiple nodes per tree, contradicting the statement we are given "a node".
#

my $graph  = do {...};  # Uses magic to read in data, which is given in an 
                        # unknown format.
                   
my $target = do {...};  # Next line of input? No clue.
my $root   = 1;


#
# Bog standard BFS
#
my @todo = ([$root, 0]);    # [node, distance from root])
my %seen;

while (@todo) {
    my ($node, $distance) = @{shift @todo}
    if ($node == $target) {
        say $distance;
        exit;
    }
    next if $seen {$node} ++;
    push @todo => map {[$_, $distance + 1]} @{$$graph {$node}}
}

say "$target does not exist, or is not connected to the root node";


__END__
