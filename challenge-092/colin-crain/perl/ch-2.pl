#! /opt/local/bin/perl
#
#       lava_lamp.pl
#
#         TASK #2 › Insert Interval
#         Submitted by: Mohammad S Anwar
#         You are given a set of sorted non-overlapping intervals and a new interval.
#
#         Write a script to merge the new interval to the given set of intervals.
#
#         Example 1:
#             Input $S = (1,4), (8,10); $N = (2,6)
#             Output: (1,6), (8,10)
#         Example 2:
#             Input $S = (1,2), (3,7), (8,10); $N = (5,8)
#             Output: (1,2), (3,10)
#         Example 3:
#             Input $S = (1,5), (7,9); $N = (10,11)
#             Output: (1,5), (7,9), (10,11)
#
#         method:
#             we will need a way to abstract our intervals, and notice whether
#             a given interval intersects with another.
#
#             This is like the who left the light on? task.
#
#             We start knowing that the intervals do not intersect.
#
#             1. sort the intervals by lower bound and secondarily by upper,
#                 after adding the new interval to the list.
#             2. working from index 0, check to see whether the upper bound is
#                 greater than the lower bound of the next iterval. If it is, we have found the
#                 index right before our interloper. We join
#                 those two intervals. The lower bound will be the lower of the
#                 first, the upper the greater of the two upper values. The added
#                 interval will be assimilated and cease to exist.
#             3. As the upper bound of the assimilated interval's relationship to
#                 the existing intervals is unknown, we need to continue until the
#                 upper bound of the current interval is less than the lower of the
#                 next interval. Only then can we can stop.
#             4. Or it it's the last interval, we should also stop then, lest we
#                 loop forever.
#
#             To join an interval with the one following, we slice out the element
#             at $idx + 1, remembering it's values. As we know the lower value of the
#             current interval is less than or equal to that of the next, so it is left
#             as-is. The upper value of the current interval is set to the greater of
#             the two upper values, current and next. The next interval has been spliced
#             and removed from the list.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:


sub main {
    my ($S, $N) = @_;
    say '';

    say "input:  ", sprint_intervals( $S );
    say "new:    ", sprint_intervals( [$N] );

    my $idx = insert_and_find_merge($S, $N);

    while (1) {
        if (defined $S->[$idx+1] and $S->[$idx][1] >= $S->[$idx+1][0]) {
            merge($S, $idx);
        }

        last if $idx == $S->@* - 1;
        last if $S->[$idx][1] < $S->[$idx+1][0];
    }

    say "merged: ", sprint_intervals( $S );

    return sprint_intervals( $S );   ## for testing purposes
}

sub insert_and_find_merge {
## insert new interval into interval list
## return index of interval to merge with next
## this will either be the insert point or one before
    my ($list, $new) = @_;
    my $idx = 0;
    my $merge;
    while ($idx < $list->@*) {
        last if $list->[$idx][0] >= $new->[0];
        $idx++;
    }
    splice $list->@*, $idx, 0, $new;

    return 0 if $idx == 0;
    return $idx-1 if $list->[$idx-1][1] >= $new->[0];
    return $idx;
}

sub merge {
## given list ref and index, merges index and index + 1
    my ($list, $idx) = @_;
    $list->[$idx][1] = $list->[$idx][1] > $list->[$idx+1][1] ? $list->[$idx][1]
                                                             : $list->[$idx+1][1];
    splice $list->@*, $idx+1, 1;
}

sub sprint_intervals {
## return formatted string
    my $list = shift;
    return  (join ' ', map { "($_->[0],$_->[1])" } $list->@*) ;
}



use Test::More;

is main( [[1,4], [8,10]],        [2,6] ),    "(1,6) (8,10)",        'ex 1 - merge first';
is main( [[1,2], [3,7], [8,10]], [5,8] ),    "(1,2) (3,10)",        'ex 2 - merge to last';
is main( [[1,5], [7,9]],         [10,11] ),  "(1,5) (7,9) (10,11)", 'ex 3 - no merge';
is main( [[4,5], [7,8], [10,12]], [1,2] ), "(1,2) (4,5) (7,8) (10,12)", 'add to front - no merge';
is main( [[1,2], [4,5], [10,12]], [7,8] ), "(1,2) (4,5) (7,8) (10,12)", 'add to middle - no merge';
is main( [[1,2], [4,5], [7,8]], [10,12] ), "(1,2) (4,5) (7,8) (10,12)", 'add to end - no merge';
is main( [[4,5], [7,8], [10,12]], [1,12] ), "(1,12)", 'add to front - all merge';
is main( [[4,5], [7,8], [10,12]], [5,15] ), "(4,15)", 'add to mid - all merge';
is main( [[4,5], [7,8], [10,12]], [5,9] ), "(4,9) (10,12)", 'add to mid - head merge';
is main( [[4,5], [6,8]], [8,12]), "(4,5) (6,12)", 'add to end - tail merge';





# is main( ), "";



done_testing();

