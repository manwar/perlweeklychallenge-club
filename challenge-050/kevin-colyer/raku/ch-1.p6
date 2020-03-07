#!perl6 
# Task 1 Challenge 050 Solution by kevincolyer
# Merge Intervals
# Write a script to merge the given intervals where ever possible.
# [2,7], [3,9], [10,12], [15,19], [18,22]
# The script should merge [2, 7] and [3, 9] together to return [2, 
# 9].
# Similarly it should also merge [15, 19] and [18, 22] together 
# to return [15, 22].
# The final result should be something like below:
# [2, 9], [10, 12], [15, 22]

use Test;

sub mergeRanges(@ranges,:$verbose=False) {
    my @merged;
    # sort
    my @unmerged=@ranges.sort({ $^a[0] <=> $^b[0] });
    # iterate array
    @merged.push(@unmerged.shift);
    while @unmerged.elems {
        say "un: {@unmerged} merged: {@merged}" if $verbose;
        if @merged[*-1][1] >= @unmerged[0][0] {
            say " merging a range" if $verbose;
            # extend range upwards
            @merged[*-1][1] = @unmerged[0][1];
            # remove as now merged
            @unmerged.shift;
        } else {
            say " copying a range" if $verbose;
            @merged.push(@unmerged.shift)
        }
    }
    return @merged;
}


my @ranges=[2,7], [3,9], [10,12], [15,19], [18,22];

is mergeRanges([[2,7],[3,9]]),[2,9],"test merging range works";
is mergeRanges([[2,5],[6,9]]),([2,5],[6,9]),"test merging range does not works";
is mergeRanges([[3,9],[2,7]]),[2,9],"test merging range works in wrong order";
is mergeRanges(@ranges),([2, 9], [10, 12], [15, 22]),"Merges multiple ranges";

done-testing;
