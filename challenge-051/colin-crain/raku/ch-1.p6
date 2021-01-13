use v6.d;

#
#       tripleplay.raku
#
#         TASK #1
#         3 Sum
#             Given an array @L of integers. Write a script to find all unique
#             triplets such that a + b + c is same as the given target T. Also
#             make sure a <= b <= c.
#
#             Example:
#
#                @L = (-25, -10, -7, -3, 2, 4, 8, 10);
#
#             One such triplet for target 0 i.e. -10 + 2 + 8 = 0.
#
#         method: when dealing with the 3SUM problem, in some way we will need
#             to in the end evaluate all possible combinations of the array for
#             a solution. Trivially, in three nested loops, this can be
#             performed in cubic time. But that explodes pretty quickly, and we
#             can do better; the challenge becomes to get that number down. One
#             way to accomplish this is to refine the search space by better
#             utilizing the information gained when we determine whether a given
#             triplet of values satisfies the conditions. When we evaluate
#             whether
#
#                 a + b + c = T
#
#             we can instead determine whether the result is greater than, less
#             than, or equal to T, and perform different actions based on the
#             cases. For example, if the sum is already too high, no solution
#             will present itself by increasing any of the values, so those
#             possiblities can be immediately determined to fail without further
#             evaluation and we can move on.
#
#             To proactively prune unproductive possibilities*, the input must
#             first be sorted. This will allow us to intelligently adjust the
#             indexes within the input array to grow or shrink the sum until an
#             equality is either reached or found impossible. We fix the "a"
#             variable to the lower end of the array, starting at index 0, and
#             assign "b" and "c" from the indexes of the lower and upper bounds
#             of the remaining range. When testing a given set of indices, if
#             the sum comes out higher than the target, we reduce the index of
#             the upper bound until it points to a lower value for "c". If the
#             sum is lower, we increase the index for "b" until it points to a
#             higher value. If we find an equality, that value of "c" will be
#             the only solution for the given "b", so "b" index is incremented,
#             and the value of "c" will then be too high for a higher value of
#             "b", so it is also decremented. Thus for any given "a" index, the
#             list of elements after it is only iterated through once per
#             element, although the actual movement is sometimes from the lower
#             bound, sometimes from the upper, towards the center.
#
#             When the upper and lower bounds meet, the index for the value for
#             "a" is incremented and the process repeated until either "a", "b",
#             and "c" are set to the last three elements in the input array, or
#             "a" is greater than the target. In this way we have still assessed
#             every possible combination, but eliminated enough logically, to
#             the point where we need not do any computation on them at all, to
#             bring the complexity back into quadratic time.
#
#             With Raku, this logic can be implemented by switching on the
#             results of the <=> operator, which returns "Less", "Same", or
#             "More". This can quite succinctly be accomplished using a
#             given/when construct and specifying fall though behavior with
#             proceed.
#
#             ——————————————————————
#             *  yes, of course that was fun to write
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN () {

    my @L = -25, -10, -7, -3, 2, 4, 8, 10;
    my $TARGET = 0;

    my @list = @L.sort({$^a <=> $^b});
    my $idx;
    my @output;

    for 0..@list.elems - 2 -> $idx {
        ## if a is greater than the target, no more solutions are possible so exit
        last if @list[$idx] > $TARGET;

        ## increment the index until a contains a new value
        next if ($idx > 0 && @list[$idx] == @list[$idx-1]);

        my $a     = @list[$idx];
        my $low   = $idx + 1;
        my $high  = @list.elems - 1;

        while $low < $high {
            ## increment the index until b contains a new value
            if ($low > $idx+1  &&  @list[$low] == @list[$low-1]) {
                $low++;
                next;
            }
            ## increment the index until c contains a new value
            if ($high < @list.elems - 1  &&  @list[$high] == @list[$high+1]) {
                $high--;
                next;
            }
            my $b = @list[$low];
            my $c = @list[$high];

            given $a + $b + $c <=> $TARGET {
                when /Less|Same/    { $low++; proceed }
                when /More|Same/    { $high--; proceed }
                when /Same/         { @output.push: [$a, $b, $c]; }
            }
        }
    }

    say $_.list.join( ', ' ) for @output;

}
