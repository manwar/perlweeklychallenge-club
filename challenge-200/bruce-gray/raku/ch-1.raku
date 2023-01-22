# I tried to decompose the task into discrete ideas:
#   * Make the longest possible groups of contiguous elements,
#     based on some property of 2 neighboring elements: f(x,y).
#   * The "property" we group on will be the difference (subtraction).
#   * Contiguous subsets of every group.
#   * Only subsets of size >= 3.
#
# Resulting details:
# * The endpoints of those groups will be shared between groups, since `f()` takes two inputs.
# * The algorithm would be the same as Run Length Encoding, except that some elements are in two groups.
#       * So, imagining the posts needed to change the "angle/direction" property of real-life fences,
#         and how those all but the first and last posts are each part of two fence segments,
#         `fencepost_grouping` was the best name I came up with for this concept.
# * Anonymous code `sub ($x,$y) { return $x - $y }` is easily abbreviated as `* - *` for the "property".
# * Sub `fencepost_grouping` also returns groups of size 2, which is an advantage to its genericity,
#   and efficiently resolved for this task by `contiguous_subsets_3_minimum` ignoring size<3.
# * I could have generated *all* subsets, even sized 0|1|2, then filtered with `grep`, but this felt inefficient.
# * In the real world, I would have passed 3 as a parameter to a more generic `contiguous_subsets()`;
#   hard-coding fit this particular task better.
# * Using LAST allowed me to combine the `gather` and `for`;
#   without LAST, the `gather` would have needed its own block.
# * I considered building a list of sizes, then returning `@ns.rotor( size1 => -1, size2 => -1 ...)`,
#   but did not pursue this design.


sub task1 ( @ns ) {
     return map &contiguous_subsets_3_minimum, fencepost_grouping(@ns, * - *);

     # Combining the component code in this way results in a second layer of grouping.
     # For example: task1([1,2,3,4,6,8,10,12,13,15,17]) returns 3 high-level groupings of the groups:
     #   ( (1 2 3) (2 3 4) (1 2 3 4) )
     #   ( (4 6 8) (6 8 10) (8 10 12) (4 6 8 10) (6 8 10 12) (4 6 8 10 12) )
     #   ( (13 15 17) )
     # I found that I preferred this result, since it provides detail
     # that would be effortful to recreate if I had flattened to single-level.
}

# @a is any list to be grouped.
# $f is the code defining the "property" to be grouped on, between two neighboring elements.
sub fencepost_grouping ( @a, Code $f where $f.arity == 2 ) {
    my ( $last_fxy, @temp );

    return gather for @a.rotor(2 => -1) -> ($x, $y) {
        my $fxy = $f.($x, $y);

        if !$last_fxy.defined or $fxy !eq $last_fxy {
            take @temp if @temp;
            @temp = Empty;
            push @temp, $x;
        }
        push @temp, $y;

        $last_fxy = $fxy;
        LAST { take @temp if @temp }
    }
}

# <a b c d e> will return <a b c>,<b c d>,<c d e>,<a b c d>,<b c d e>,<a b c d e>
sub contiguous_subsets_3_minimum ( @a ) {
    return @a < 3 ?? Empty !!
        (3 .. +@a).map: -> $size { |@a.rotor( $size => (1 - $size) ) }
}

say task1([1,2,3,4]);

say task1([]);
# ENOTENOUGHTIME: Commentary is awkwardly worded; more time needed to enhance comprehendability.
