# You are given an array of positive numbers @A.
#
# Write a script to find the largest rectangle histogram created by the given
# array.  BONUS: Try to print the histogram as shown in the example, if
# possible.
#
# Example 1:
#
# Input: @A = (2, 1, 4, 5, 3, 7)
#
#      7           #
#      6           #
#      5       #   #
#      4     # #   #
#      3     # # # #
#      2 #   # # # #
#      1 # # # # # #
#      _ _ _ _ _ _ _
#        2 1 4 5 3 7
#
# Looking at the above histogram, the largest rectangle (4 x 3) is formed by
# columns (4, 5, 3 and 7).
# Output: 12
#
# Example 2:
#
# Input: @A = (3, 2, 3, 5, 7, 5)
#
#      7         #
#      6         #
#      5       # # #
#      4       # # #
#      3 #   # # # #
#      2 # # # # # #
#      1 # # # # # #
#      _ _ _ _ _ _ _
#        3 2 3 5 7 5
#
# Looking at the above histogram, the largest rectangle (3 x 5) is formed by
# columns (5, 7 and 5).
# Output: 15

# Without the BONUS. ;)

sub largest-rec-hist(@A) {
    my @largest-sub-rec = [];
    for 0..(@A.elems - 1) -> $i {
        for ($i + 1)..(@A.elems - 1) -> $j {
            @largest-sub-rec.push(($j - $i + 1) * @A[$i..$j].min);
        }
    }
    return @largest-sub-rec.max;
}

largest-rec-hist((2, 1, 4, 5, 3, 7)).say;
largest-rec-hist((3, 2, 3, 5, 7, 5)).say;
