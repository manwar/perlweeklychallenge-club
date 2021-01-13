use v6.d;

#
#       56-2-pathsum.raku
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
#             For the given binary tree, the partial path sum 5 → 8 → 9 = 22 is
#             not valid.
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
#             If I was to build this structure for some practical use, a
#             natural way would be to define a tree node class and add in nodes
#             as we aquire the data. This could be done with a proper
#             Class, but at its heart each node is a hash
#             with three keys: {left}, {right} and {value}, to hold the value
#             and references (or undef) for the left and right children .
#
#             Using a Node class, the example might then look like this:
#
#                 class Node {
#                     has Node $.left;
#                     has Node $.right;
#                     has $.value;
#
#                 my Node $tree .= new( value => 5,
#                                        left => Node.new( value => 4,
#                                                           left => Node.new( value => 11,
#                                                                              left => Node.new(value => 7),
#                                                                             right => Node.new(value => 2)
#                                                                            )
#                                                         ),
#                                       right => Node.new( value => 8,
#                                                           left => Node.new( value => 13),
#                                                          right => Node.new( value => 9
#                                                                             right => Node.new( value => 1)
#                                                                            )
#                                                         )
#                                      );
#
#             That's untested, but I'm pretty sure that's right. But this isn't
#             a very practical way to give anything to anybody, is it? Once
#             loaded it provides the functionality (maybe add some methods), but
#             it's hardly command-line friendly.
#
#             A third way of implimenting this structure is to imagine every
#             node in every rank as complete, assigning the values of the nodes
#             into fixed indices of an array; starting with the rank 0 node at
#             index 0, proceeding with the next level into indices 1 and 2,
#             etcetera, we give every node an index in a level-first traversal.
#             A given index for a null set child is filled with a null value,
#             Nil in this case, and its theoretical children down the line get
#             null values as well, thus maintaining synchronization with the
#             level structure no matter the shape of the actual tree. Each child
#             is located relative to its parent, index n, at indices 2n + 1 and
#             2n + 2, so traversing a given path is a matter of following from
#             parent to child, recusively, as long as there is another defined
#             value to jump to.
#
#             In this manner the example tree can be encoded, in raku, as
#
#                 @tree = 5, 4, 8, 11, Nil, 13, 9, 7, 2, Nil, Nil, Nil, Nil, Nil, 1
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
#             Tweaking the algorithm to give a semi-random tree that also
#             provided a good demonstration example proved more complicated than
#             I first expected, but after a little work tuning the odds of a
#             node spawning children, I think we're there. In execution, the
#             odds of any given node as being a terminator increase as the
#             level, or rank, increases; degenerate trees just aren't very
#             interesting. A high point was the little function, get_rank($n),
#             that reverse-engineers the construction algorithm to produce the
#             rank level from an input index, rather than keeping a count
#             somehow.
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

sub MAIN ($depth = 3) {

    my @tree = generate_tree($depth);

    my $tstr = @tree.map({$_.defined ?? $_ !! "undef"}).join(', ');
    my $target = (($depth+1) * 4.5).Int;

    say qq:to/__END__/;
    tree:   $tstr
    target: $target

    paths found:
    __END__

    my $index = 0;
    my @working;
    my @paths;
    sum_path(@tree, $target, $index, @working, @paths);

    say "\nsolutions:\n";
    @paths.elems == 0 ?? say '(none)' !! ($_.join(' -> ').say for @paths);
}

## ## ## ## ## SUBS:

sub sum_path (@tree, $target, $index, @prev_working, @paths) {
## walks the tree and computes complete the path sum
    my @working = @prev_working;
    @working.append: @tree[$index];

    ## if we are at a terminal node check the sum and return
    if ( ! @tree[$index * 2 + 1].defined && ! @tree[$index * 2 + 2].defined ) {
        my $sum = [+] @working;
        @paths.push: @working if $sum == $target;

        say @working.join(' + ') ~ " = $sum";

        return;
    }

    for ( $index * 2 + 1, $index * 2 + 2 ) -> $child {
        sum_path( @tree, $target, $child, @working, @paths ) if @tree[$child].defined;
    }
}

sub generate_tree ($depth){
## automatically generates a random binary tree of rank n, with node values 1..10
## odds of a node being a terminator increase as the rank of the node increases
## which avoids trees with branches that quickly end
    my @tree;
    @tree[0]  = (^10).pick;            ## always defined
    my $nodes = (2**($depth+1)) - 2;   ## 0-based count to last node, (start of next rank - 1)

    for ( 0..$nodes ) -> $index {
        my $rank = get_rank($index);
        my $parent = (($index-1)/2).Int;
        if @tree[$parent].defined {
            ## the odds of the switch being 0 increase as the rank progresses
            ## the first node will always generate the next rank
            my $switch = $index > 0 ?? (^($nodes - 2 ** $rank)/2).pick.Int !! 1;
            @tree[$index] = $switch ?? (^10).pick !! Nil;
        }
    }
    return @tree;
}

sub get_rank ($n) {
## determines the rank of a node from its index
    return $n > 0 ?? (log($n+1)/log(2)).Int !! 0;
}

