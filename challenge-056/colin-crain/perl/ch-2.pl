#! /opt/local/bin/perl
#
#       56_2_pathsum.pl
#
#         PWC 56 - TASK #2
#         Path Sum
#             You are given a binary tree and a sum, write a script to find if
#             the tree has a path such that adding up all the values along the
#             path equals the given sum. Only complete paths (from root to leaf
#             node) may be considered for a sum.
#
#             Example
#             Given the below binary tree and sum = 22,
#
#                       5
#                      / \
#                     4   8
#                    /   / \
#                   11  13  9
#                  /  \      \
#                 7    2      1
#
#             For the given binary tree, the partial path sum 5 → 8 → 9 = 22 is not valid.
#
#             The script should return the path 5 → 4 → 11 → 2 whose sum is 22.
#
#         method:
#
#             The challenge is on the surface pretty straightforward; the binary
#             tree data structure was designed to be transversed, so a recursive
#             routine that walks the paths until it finds a terminator node
#             would do the trick. Once the path is found, we can compare the sum
#             and if it fits log it.
#
#             The problem rears its head here with the phrase “given a binary
#             tree and a sum”.  What does that mean? Not what is a binary tree,
#             of course. But what does it mean here? We are given an ascii
#             drawing of an example tree. Although I spent more time than I’d
#             like to admit considering directly parsing this format it’s
#             ill-defined itself and a totally useless effort. Not that that
#             ever stopped me before, mind you; I still may get to it. For the
#             greater good. For the ASCII art. Maybe a reader and writer. Sure
#             thing, get right on it...
#
#             But how then, should we encode our tree? In Set theory, each node
#             of a binary tree can be defined as {L, S, R} for the Left child,
#             Singleton value, and Right child sets. The value is a Singleton
#             set, the others binary tree sets themselves or empty sets.* The
#             example tree could thusly be encoded:
#
#                 {{{∅,7,∅},11,{∅,2,∅}},4,∅},5,{{∅,13,∅},8,{∅,9,{∅,1,∅}}}
#
#             If I was to build this structure in perl for some practical use, a
#             natural way would be to define a tree node object and add in nodes
#             as we aquire the data. This could be done with a blessing a proper
#             Node objects, in a package, but at its heart each node is a hash
#             with three keys: {left}, {right} and {value}, to hold the value
#             and references (or undef) for the left and right children .
#
#             The example would then look like this:
#
#                 $data = {   value   => 5,
#                             left    => {  value => 4,
#                                           left  => { value => 11,
#                                                      left  => {  value => 7,
#                                                                  left  => undef,
#                                                                  right => undef
#                                                               }
#                                                      right => {  value => 2,
#                                                                  left  => undef,
#                                                                  right => undef
#                                                               }
#                                                    }
#                                           right => undef
#                                        }
#                             right   => {  value => 8,
#                                           left  => { value => 13,
#                                                      left  => undef,
#                                                      right => undef
#                                                    }
#                                           right => { value => 9,
#                                                      left  => undef
#                                                      right => { value => 1,
#                                                                 left  => undef,
#                                                                 right => undef
#                                                               }
#
#             But this isn't a very practical way to give anything to anybody,
#             is it? Once loaded it provides the functionality, but it's hardly
#             command-line friendly.
#
#             A third way of implimenting this structure is to imagine every
#             node in every rank as complete, assigning the values of the nodes
#             into fixed indices of an array; starting with the rank 0 node at
#             index 0, proceeding with the next level into indices 1 and 2,
#             etcetera, in a level-first traversal. A given index for a null set
#             child is filled with a null value, undef for Perl, and its
#             theoretical children with null values as well, thus maintaining
#             synchronization with the level structure no matter the shape of
#             the actual tree. Each child is located relative to its parent,
#             index n, at indices 2n + 1 and 2n + 2, so traversing a given path
#             is a matter of following from parent to child, recusively,
#             as long as there is another defined value to jump to.
#
#             In this manner the example tree can be encoded, in perl, as
#
#                 @tree = (5, 4, 8, 11, undef, 13, 9, 7, 2, undef, undef, undef, undef, undef, 1)
#
#             Notice there's a fair amount of wasted space in this encoding, as
#             every node must be given an index, whether it's populated or not,
#             or even whether its parent exists or not. It does provide a simple
#             relationship between parent and child nodes that can be easily
#             visualized for smaller trees. Due to its fairly compact serialized
#             nature and (mostly) human readable form we will use this method to
#             encode our tree.
#
#             Traversing all possible paths in the tree using a recursive
#             routine as described is executed in sum_path(), below. Originally
#             I allowed passing in a target and tree array from the commandline,
#             but found that even though the serialized tree format is somewhat
#             human-readable, writing an arbitrary new tree to demonstrate the
#             behavior proved troublesome, to say the least. So alternately, I
#             decided it was easier to make functions that generates random
#             trees and median targets, and used those for input data instead.
#             Tweaking the algorithm to give a semi-random tree that also was a
#             good demonstration example proved more complicated than I first
#             expected, but after a little work I think we're there. The odds of
#             any given node as being a terminator increase as the level, or
#             rank, increases. A high point was the little function that
#             reverse-engineers the construction algorithm to produce the rank
#             level from an input index.
#
#             In the output, the input tree is listed, along with the target.
#             Because I thought it was interesting, all traversals are noted as
#             they are found, with their sums. At the end, the data asked for,
#             those paths that sum to the target, are listed.
#
#
#             --------------------
#             * Discrete Mathematics : Proofs, Structures and Applications,
#             Third Edition (Garnier, Rowan, Taylor, John) 2009
#
#             "A binary tree comprises a triple of sets (L, S, R) where L and R
#             are binary trees (or are empty) and S is a singleton set. The
#             single element of S is the root, and L and R are called,
#             respectively, the left and right subtrees of the root."
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:
our $depth = 4;
our @tree = generate_tree($depth);
say "tree:   ", join ', ', map {defined $_? $_ : "undef"} @tree;

our $target = shift // int (($depth+1) * 4.5) ;
say "target: $target";
say "";
say "paths found:\n";

my  $index   = 0;
my  $working = [];
our $paths   = [];
sum_path ($index, $working);

say "\nsolutions:\n";
if (scalar $paths->@* == 0)  {
    say '(none)';
}
else {
    say join ' -> ', $_->@* for $paths->@*;
}


## ## ## ## ## SUBS:

sub sum_path {
## walks the tree and computes complete the path sum
    my ($index, $working) = @_;
    my @working = $working->@*;
    push @working, $tree[$index];

    ## if we are at a terminal node check the sum and return
    if ( ! defined $tree[$index * 2 + 1] && ! defined $tree[$index * 2 + 2] ) {
        my $sum;
        $sum += $_ for @working;
        push $paths->@*, \@working if ($sum == $target);

        print (join ' -> ', map {defined $_ ? $_ : "undef"} @working);
        say " = $sum";

        return;
    }

    ## walk to next nodes if present
    for my $child ( $index * 2 + 1, $index * 2 + 2 ) {
        sum_path( $child, \@working ) if defined $tree[$child];
    }
}

sub generate_tree {
## automatically generates a binary tree of rank n.
## odds of a node being a terminator increase as the rank of the node increases
## which avoids trees with branches that quickly end
    my $depth = shift;
    my @tree;
    $tree[0] = int(rand(10));          ## always defined
    my $nodes = (2**($depth+1)) - 2;   ## 0-based count to last node, start of next rank - 1

    for my $index ( 0..$nodes ) {
        my $rank = get_rank($index);   ## determines the rank of a node from its index
        my $parent = int(($index-1)/2);
        if ( defined $tree[$parent]) {
            ## the odds of the switch being 0 increase as the rank progresses
            ## the start node, rank 0, will always generate the next rank
            my $switch = $index > 0 ? int(rand ($nodes - 2 ** $rank)/2) : 1 ;
            @tree[$index] = $switch ? int(rand(10)) : undef;
        }
    }
    return @tree;
}

sub get_rank {
## determines the rank of a node from its index
    my $n = shift;
    return $n > 0 ? int log($n+1)/log(2) : 0;
}
