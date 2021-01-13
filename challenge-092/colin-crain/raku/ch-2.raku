#!/usr/bin/env perl6
#
#
#       lava_lamp.raku
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
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (*@input) ;
## the input is an array of values.
## the first two elements will be the lower and upper bounds of the interval
##      to be inserted
## the remaining elements will be the lower and upper bounds pairs the sorted,
##      non-overlapping interval list as specified

@input.elems == 0 and @input = 5, 9, 4, 5, 7, 8, 10, 12;        ## sample data

my $N = @input.head(2);
my @S = @input.tail(*-2).rotor(2);

say "start:  ", @S;
say "added:  ", $N;

## insert and find merge point
my $idx = 0;
while $idx < @S.elems {
    last if @S[$idx][0] >= $N[0];
    $idx++;
}
@S = |@S[^$idx], $N, |@S[$idx..*];          ## splice but keep container

my $merge = 0;
$merge    = $idx if $idx;
$merge    = $idx-1 if @S[$idx-1][1] >= $N[0];

## merge until conflicts are resolved
loop {
    if $merge < @S.end and @S[$merge][1] >= @S[$merge+1][0] {
        @S[$merge][1] = (@S[$merge][1], @S[$merge+1][1]).max;
        @S.splice: $merge+1, 1;
    }
    last if $merge == @S.end;
    last if @S[$merge][1] < @S[$merge+1][0];
}

say "merged: ", @S;

