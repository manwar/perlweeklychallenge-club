#
# Word Ladder
# A word ladder is a sequence of words [w0, w1, …, wn] such that each word wi in the sequence is obtained by
# changing a single character in the word wi-1.
# All words in the ladder must be valid English words.

# Given two input words and a file that contains an ordered word list, implement a routine
# (e.g., find_shortest_ladder(word1, word2, wordlist)) that finds the shortest ladder between the two input words.
# For example, for the words cold and warm, the routine might return:

# ("cold", "cord", "core", "care", "card", "ward", "warm")
# However, there’s a shortest ladder: (“cold”, “cord”, “card”, “ward”, “warm”).

# Givens:
# All words in the list have the same length.

# All words contain only lowercase alphabetical characters.

# There are no duplicates in the word list.

# The input words aren’t empty and aren’t equal but they have the same length as any word in the word list.

# Requirements:
# The routine must return a list of the words in the ladder if it exists.
# Otherwise, it returns an empty list.

# If any of the input words is the wrong length (i.e., its length is different to a random from the word list)
# or isn’t in the word list, return an empty list.

use strict;
use warnings;
use utf8;
use v5.10;

# before entering the problem, we will get the input data

my ( $word1, $word2 ) = ( shift, shift );
my @wordlist = <>;
chomp @wordlist;

# now we call the function defined on the challenge. It will return an empty list on errors or
# if the target word ($word2) is unreachable

say for find_shortest_ladder( $word1, $word2, @wordlist );

# before start with the find_shortest_ladder function,
# we will need some other function to evaluate if two words are adjacent

sub are_adjacent {
    my ( $w1, $w2 ) = @_;
    my $diffs = 0;
    my @l1    = split '', $w1;    # letters of $w1
    my @l2    = split '', $w2;    # letters of $w2
    for my $i ( 0 .. $#l1 ) {
        $diffs++ if $l1[$i] ne $l2[$i];
    }
    return $diffs == 1
      ; # will return true if $w1 has only one leter difference with $w2 (i.e. they are adjacent)
}

# now we define the actual function required by the challenge.
#
# as we are looking for shortest path, we will use Dijkstra algorithm (https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm)
# we will arrange all data in a hash that we will call %nodes.
# each key of that hash will correspond to a node, including start and end nodes ($word1 and $word2)
# each node will have an asociated hash with the properties that we need for Dijkstra algorithm:
#
# ->{visited} will exist and be true for visited nodes
# ->{cost} will exist and have an integer number equal to the minimal amount of
#          edges we have to cross to get there with the paths we checked so far
# ->{from} will exist and have the name of the node previous to get the cost above
#
# note that all that properties will not exist when we start the algorithm
#
sub find_shortest_ladder {
    my ( $word1, $word2, @wordlist ) = @_;

    # we need to do some checks now as requested in the challenge
    return ()
      unless defined $word1
      && defined $word2
      && length($word1)
      && length($word1) == length($word2)
      && !grep { length($word1) != length } @wordlist;
    my %nodes = ( $word1 => { cost => 0 }, $word2 => {} );
    $nodes{$_} = {} for @wordlist;
#
# note that all nodes are unvisited at this time
# according to our model, we can find all nodes (an array with the words), like this:
#
# @all = keys %nodes;                                                                   (1)
#
# and a list of unvisited nodes like this:
#
# @unvisited = grep {!$nodes{$_}{visited}} keys %nodes;                                 (2)
#
# we could also select the unvisited nodes adjacent to a particular node $w1:
#
# @adjs_unvisited = grep {are_adjacent($w1, $_)  && !$nodes{$_}{visited}} keys %nodes;  (3)
#
# also we can establish wich are the nodes that we are able to reach now, because
# they have a defined cost
#
# @reachables = grep {defined $nodes{$_}{cost}} keys %nodes                             (4)
#
    my $current = $word1;
    while ( defined $current && $current ne $word2 ) {

# we will mark current node as visited, so we will work with this one, and never come back
        $nodes{$current}{visited} = 1;
        my @unvisited =
          grep { !$nodes{$_}{visited} } keys %nodes;    # see (2)
        my $cost = $nodes{$current}{cost} + 1;

        # now we just filter adjacents nodes from all non visited, see (3)
        for my $node ( grep { are_adjacent( $current, $_ ) } @unvisited ) {

       # check if new path is shorter
       # note that indefined cost is like "infinite" cost for Dijkstra algorithm
            if ( !defined $nodes{$node}{cost} || $nodes{$node}{cost} > $cost ) {
                $nodes{$node}{cost} = $cost;
                $nodes{$node}{from} = $current;
            }
        }

        # after estimating cost to all not visited adjacents, we need to define
        # a new node to visit (next $current).
        # as for Dijkstra algorithm, we will choose the unvisited node with the
        # lower estimated cost so far
        my $min_cost;
        undef $current;
        for my $node (@unvisited) {
            next
              unless defined $nodes{$node}{cost}
              ;    # don't care about unreached nodes
            if ( !defined $min_cost || $nodes{$node}{cost} < $min_cost ) {
                $current  = $node;
                $min_cost = $nodes{$node}{cost};
            }
        }

        # at this point, if $current is not defined means we couldn't get a path
    }
    return () unless defined $current;    # didn't success, return empty list
         # found shortest path, we will go backwards to reconstruct it
    my @path = $current;
    unshift @path, $nodes{ $path[0] }{from} while ( $path[0] ne $word1 );
    return @path;
}
