use v6.d;

#
#       invert_sugar.raku
#
#       TASK #1 › Invert Tree
#         You are given a full binary tree of any height, similar to the one
#         below:
#                    __1__
#                   /     \
#                  2       3
#                 / \     / \
#                4   5   6   8
#
#         Write a script to invert the tree, by mirroring the children of every
#         node, from left to right. The expected output from the tree above
#         would be:
#                    __1__
#                   /     \
#                  3       2
#                 / \     / \
#                8   6   5   4
#
#         The input can be any sensible machine-readable binary tree format of
#         your choosing, and the output should be the same format.
#
#         BONUS In addition to the above, you may wish to pretty-print your
#         binary tree in a human readable text-based format similar to the
#         following:
#
#                1
#               /  \
#              3    2
#             / \  / \
#            7   6 5  4
#
#         method: The raku version of this challenge is pretty much a port of
#             the perl version.
#
#             Continuing on from the notes from last week, the PWC 56-2
#             Sum Path problem there required a binary tree, and we discussed
#             the problems of inputting such a structure as a command-line
#             argumant. As such, node classes and pointer references are all
#             well and good for a data structure held in memory, but for
#             serialized input are sorely lacking. One solution to this problem
#             lies in reducing a binary tree to a specific fixed-size array,
#             with indices allocated along a level-first traversal of the tree
#             for each possible node at every level. Absent branches and child
#             nodes are represented by an undef null value and positional
#             integrity is maintained for all parent-child node relationships,
#             generalized as
#
#                     P(n) --> C1(2n+1), C2(2n+2)
#
#             It also has the quality of being somewhat human-readable for
#             smaller trees, which is nice. So we're going to go ahead and use
#             that again.
#
#             One thing to notice this week is that we are specifically given a
#             full binary tree, which is to say every node has either 0 or 2
#             children, but it is not specified that all paths descend to the
#             same depth, only that the depth can be any height. This
#             restriction is curious, and notably it is only a requirement for
#             the tree to be full, but not necessarily complete or prefect, such
#             as with all branches having two children, or all levels present
#             filled. So we have quite a bit of latitude in our construction,
#             even allowing for some variation in those definitions.
#
#             In any case, the data format we have chosen does require that we
#             allow an array index for every possible node within every level.
#             In using this format, we are making a small modification to the
#             standard recursive set theory definition of a binary tree: as a
#             set of node sets of TreeNode:{L,S,R}, with L and R being TreeNode
#             sets and S being a Singleton value. Here we will accept the case
#             {∅,∅,∅} to be a proper node, or essentially allowing a
#             well-defined placeholder for the absence of data. This allows
#             every possible tree to be defined in our format, but at the same
#             time every tree is thus contained within a definition of an
#             encompassing theoretical perfect tree of the same maximum level,
#             with the caveat that some nodes within this outer tree may only
#             contain an absence of data. The upshot is that by using this
#             format, the method will as required work for all full trees, and
#             in addition any other tree one wishes to throw at it, no matter
#             how pathologically degenerate.
#
#             Because the levels are laid out sequentially, and positional
#             mapping is well-defined both between and within levels, inverting
#             a tree in this format is reduced to selecting out the various
#             levels within the array, reversing them and reconstituting the
#             structure.  This is accomplished in
#
#                 invert_tree()
#
#             below. It works by first logarithmically extracting the maximum
#             level of the tree from the last index value, because the size of
#             levels progress along the pattern 1,2,4,8,16... or 2^n where
#             n=0,1,2,3,4... From that the number of level nodes is calculated,
#             the section extracted using splice() and reversed, and a new array
#             constructed.
#
#             Now to the meat of the matter:
#
#             The observant reader from last week will recall I had made
#             reference to considering the problem of drawing ASCII binary tree
#             output, presenting the tree structure visually. To quote myself:
#
#                 Although I spent more time than I’d like to admit
#                 considering directly parsing this format it’s ill-defined
#                 itself and a totally useless effort. Not that that ever
#                 stopped me before, mind you
#
#             So then, on to what took up the most part by far of my efforts
#             these last few days.
#
#             Fortunately I had been tinkering and had a head start, because the
#             more I thought, the more it became clear whole operation was
#             decidedly non-trivial. If the problem is, as I declared,
#             ill-defined, the first thing to do would be to define it. After
#             drawing out tree after tree in various ways, it became apparent
#             that the physical size of the data was a locus in the problem
#             space, around which circled various difficulties in preventing
#             both adjacent values from the same parent and those from different
#             branches from overlapping. Further, these interstitial voids need
#             to expand as we propagate up the tree according to some elusive
#             patterning, both for the whitespace and the connecting lines. And
#             further, if I was going to go through all this trouble it had to
#             look nice, with pleasing mirroring and symmetry. After all that is
#             the point, isn't it? To be looked at?
#
#             The result is
#
#                 print_tree()
#
#             below. Even after quite a bit of refactoring, it's definitely the
#             hairiest thing I've written in some time. it could perhaps do with
#             some more, but it works and again I'm out of time.
#
#             Essentially the shape is a series of vertically compressed linked
#             triangles, with dashes taking the place of long paths of / and \
#             characters, drawing larger and larger connecting branches. It's
#             somewhat reminiscent of a Sierpiński triangle, although in this
#             case the adjectant R and L branches from different nodes cannot
#             meet and overlap. The allocated space for individual values is all
#             dependant on the largest physical representation amongst all the
#             values, with smaller values centered in the space allotted. Yes,
#             of course I had to roll up a special sprintf format to do the
#             centering, as it just didn't look right. It works for seemingly
#             any width data and any theoretical depth, although the trees will
#             get quite large on the page. I've left some alternate trees from
#             testing should anyone with to try different variations. Try the
#             really big one, it's cool.
#
#             The method does not do much checking for malformed input, with the
#             small exception of a simple routine that ∅ pads the input array to
#             fill the last layer. This forces the array length to extend to
#             every posssible node, should it have been truncated somewhere
#             along the line, say for the commandline input I didn't see the
#             driving need to implement. For example, the array (1,2,3,4) will
#             be changed to (1,2,3,4,undef,undef,undef). Technically we should
#             probably just not allow the former, but I was feeling generous.
#             This is the
#
#                     complete_tree()
#
#             routine at the end. Malformed trees, such as having children
#             without parents, will still pass through the printer, but those
#             children will float in space, unconnected to society and alone.
#             Please don't do this. Life is hard enough.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN () {

    my @tree =  184, 345, 200, 538, Nil, 988, 784, 207, 701, Nil, Nil, 431, 514,
                843, 487, 226, 102, Nil, 665, Nil, Nil, Nil, Nil, 704, 213, Nil, Nil, 838, 127;

    ## alternately, try these:
    # my @tree = (5, 4, 8, 1, undef, 3, 9, 7, 2, undef, undef, undef, undef, undef, 1);
    # my @tree = (1010, 1010, 1010, 1010, 3030, 1010, 1010, 7070, 1010, 3030, 4040, 5050, 6060, 7070, 1111);
    # my @tree = (6, 8, 6, 2, 5, 3, 9, 9, 3, 6, 0, 5, 1, 2, 1, 6, 9, undef, 6, 8, 4, 5, 9, 3, 5,
    #             7, 1, 5, 1, 1, 1, 5, 0, 9, 0, undef, undef, 1, 3, 2, 3, 3, 0, 0, 5, 1, 4, 2, 9,
    #             0, 2, 8, 7, 4, 7, 2, 8, 9, 6, 6, 0, 6, 3, 9, 4, 4, 3, 1, 7, 8, 8, undef, undef,
    #             undef, undef, 4, 5, 6, 6, 9, 6, 4, 8, 4, 6, 7, 1, undef, 5, 2, 5, 1, 2, 5, 8,
    #             0, 5, 2, 9, 3, 7, 2, 4, 2, 2, 3, 4, 2, 5, 7, 8, 4, 7, 2, 6, 3, 1, 0, 7, 2, 8,
    #             4, 4, 5, 0, 1, 8, 4, 8, 6, 3, 3, 0, 5, undef, 9, 5, 2, 0, 9, 9, 3, 5, undef,
    #             undef, undef, undef, undef, undef, undef, undef, 5, 3, 6, 8, 8, 2, 2, 3, 6, 0,
    #             9, 5, 2, undef, 9, 6, 4, 8, 7, 1, 1, 1, 7, 3, undef, undef, 4, 0, 3, 3, 2, 9,
    #             2, 4, 3, 5, 2, 8, 3, 5, 3, 2, 6, 6, 6, 4, 6, 0, 8, 5, 9, 2, 8, 1, 0, 8, 7, 2,
    #             7, 6, 8, 5, 3, 5, 7, 9, 4, 9, 9, 4, 0, 2, 9, 1, 6, 5, 4, 7, 4, 6, 4, 3, 0, 0,
    #             0, 3, 8, 4, 5, 4, 0, 5, 7, 5, 8, undef, 8, 0, 1, 2, 8, 8, 8, 2);
    # my @tree = (1, 2, 3, undef, undef, 5);
    # my @tree = (1, 48, 2, 321, undef, 3, 4, 747, 15, undef, undef, "Hi!", undef, 963, 100);

    complete_tree(@tree);

    put "input:";
    @tree.map({$_.defined ?? $_ !! "∅"}).join(', ').say;
    print_tree(@tree);

    invert_tree(@tree);

    put "inverted:";
    @tree.map({$_.defined ?? $_ !! "∅"}).join(', ').say;

    print_tree(@tree);

}

sub complete_tree (@tree) {
## complete a malformed tree array
## explicitly grow a binary tree array in place to fill the last level with Nil as required
## (1,2,3,4) -> (1,2,3,4,Nil,Nil,Nil)
    my $last_level = get_level( @tree.end ) + 1;
    @tree[2**$last_level - 2] //= Nil;
}

sub get_level ($n) {
## determines the 0-based level of a node from its index
    return $n > 0 ?? (log($n+1)/log(2)).Int !! 0;
}

sub invert_tree (@tree) {
## symmetrically mirrors a binary tree on the right/left axis
## I wouldn't use the word "invert" here
    my $max_level = get_level( @tree.end );
    my @output;

    for 0..$max_level -> $level {
        my $level_size = 2 ** $level;
        my @level =  @tree.splice( 0, $level_size );
        @output.append: @level.reverse;
    }

    @tree = @output;
}

sub print_tree (@tree) {
## could still do with some refactoring I'm sure, but tested on a wide variety of inputs

    my $max_width  = get_max_value_width(@tree);         ## the max char width of all values

    ## magic here, as we get longer values we pretend we're at the top of a larger tree to keep from
    ## running out of space between adjacent values between two parent nodes on the lowest level
    my $num_levels = get_level(@tree.end) + ($max_width/2).Int;

    my $index = 0;

    while ($index < @tree.elems) {
        my $level   = get_level($index);

        my $spacer = 2**($num_levels - $level + 1);
        my $white  = ($spacer/2 + 1 + $max_width) > $spacer ?? $spacer !! $spacer/2 + 1 + $max_width;
        my $dashes = $spacer - $white;

        my $level_node_count = 2 ** $level;             ## number of nodes on this level

        my $node_line;
        my $slash_line;

        ## draw the nodes of each level and any connecting lines to the next
        for (1..$level_node_count) {

            ## if the node is defined draw it in
            if (defined @tree[$index]) {

                ## centers value in a slot $max_width wide, leaning right for odd fits
                my $this_width = @tree[$index].comb.elems;
                my $right_pad_count = (($max_width - $this_width)/2).Int;
                my $right_pad = ' ' x $right_pad_count;
                my $left_pad  = ' ' x ($max_width - $this_width - $right_pad_count);
                my $value_format = "$left_pad%" ~ "$this_width" ~ "s$right_pad";
                my $node = sprintf $value_format, @tree[$index];

                ## draw connecting lines if children present, or whitespace if not
                my $left_branch  =  @tree[2 * $index + 1].defined
                                    ?? ' ' x $white  ~ '_' x $dashes
                                    !! ' ' x $spacer;
                my $right_branch =  @tree[2 * $index + 2].defined
                                    ?? '_' x $dashes ~ ' ' x ($white-$max_width)
                                    !! ' ' x ($spacer-$max_width);
                $node_line  ~= $left_branch ~ $node ~ $right_branch;
                my $left_slash   =  @tree[2 * $index + 1].defined
                                    ?? ' ' x ($spacer/2+$max_width) ~ "/" ~ ' ' x $dashes
                                    !! ' ' x $spacer;
                my $right_slash  =  @tree[2 * $index + 2].defined
                                    ?? ' ' x ($dashes+$max_width) ~ "\\" ~ ' ' x ($spacer/2)
                                    !! ' ' x $spacer;
                $slash_line ~= $left_slash ~ $right_slash;
            }
            ## else insert equivalent whitespace
            else {
                $node_line  ~= ( ' ' x (2 * $spacer));
                $slash_line ~= ( ' ' x ($spacer + 2 + $dashes*2 + $max_width*2));
            }
            $index++;
        }
        say $node_line;
        say $slash_line;
    }
}

sub get_max_value_width (@tree) {
## determines the widest character string representation is the array and returns the width
    return @tree.map({.defined ?? $_.comb.elems !! 0}).max;
}
