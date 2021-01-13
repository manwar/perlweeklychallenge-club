# Merge Intervals
#
# Write a script to merge the given intervals where ever possible.
#
#     [2,7], [3,9], [10,12], [15,19], [18,22]
#
# The script should merge [2, 7] and [3, 9] together to return [2, 9].
#
# Similarly it should also merge [15, 19] and [18, 22] together to return [15,
# 22].
#
# The final result should be something like below:
#
#     [2, 9], [10, 12], [15, 22]
#

sub merge-int(@intervals) {
    if (@intervals.elems < 2) {
        return @intervals;
    }

    # Sort intervals ascending.
    @intervals = @intervals.sort;

    my ($a1, $a2) = @intervals.head;
    for 1..^@intervals.elems -> $i {
        if ($a2 < @intervals[$i][0]) {
            return [($a1, max($a2, @intervals[$i-1][1])),
                    |(merge-int(@intervals[$i..*]))];
        }
    }

    return [($a1, max($a2, @intervals[*-1][1])),];
}

say merge-int([(2, 3), (-1, 2), (5, 6)]);
say merge-int([(2, 7), (3, 9), (10, 12), (15, 19), (18, 22)]);
