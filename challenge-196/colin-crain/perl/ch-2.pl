#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       down-range.pl
#
#       Range List
#         Submitted by: Mohammad S Anwar
#         You are given a sorted unique integer array, @array.
# 
#         Write a script to find all possible Number Range i.e [x, y]
#         represent range all integers from x and y (both inclusive).
# 
#         Each subsequence of two or more contiguous integers
# 
#         Example 1
#             Input: @array = (1,3,4,5,7)
#             Output: [3,5]
# 
#         Example 2
#             Input: @array = (1,2,3,6,7,9)
#             Output: [1,3], [6,7]
# 
#         Example 3
#             Input: @array = (0,1,2,4,5,6,8,9)
#             Output: [0,2], [4,6], [8,9]

#         breakdown
# 
#         I had to read this and study the examples several times before I
#         got the jist of what was being requested here. Rephrased, we are
#         given a list of ascending integers, and are asked to isolate out
#         contiguous runs of sequental values that can be represented with
#         ranges, and return the ranges.
# 
#         Ranges fro the purposes of discussion are assumed to have the
#         most restrained and basic definition: sequential ascending values
#         differing by 1. No funny stuff.
# 
#         An immediastely useful observation that will make our search
#         simpler is that the ranges cannot overlap or even abut, and this
#         will immediately stimulate reverse mitosis and the two ranges
#         will spontaniously merge into one single larger element. So as we
#         look for ranges, we know they will have distinct boundaries.
# 
#         method
# 
#         The essental pattern to recognize here is two seqential elements
#         in the input array that increase in value by 1. If we walk the
#         list from left to right, then, if the next element differs from
#         the previous by 1, it is in a range with it, and if the
#         difference is any other number it is not.
# 
#         What we can do, then, is iterate over the indices of the target
#         array from 0 to the second-to-last. Looking at each index value,
#         if the next index value is one more we have a range, with a low
#         of the current index and a high of the next. Moving to the next,
#         if the difference is 1 again we extend the working range making
#         that value the new high. If it is not in the range, however, the
#         current range is closed as-is and stored away or even printed
#         immediately, and then the working range is wiped clean.
# 
#         After evaluating the second-to-last index, if we still have a
#         working range it is added to the output, but if that range is nil
#         it is left off.
# 
#         In this way we can process the whole array in one pass.
# 
# 
#         I seem to recall another challenge that was solvable using a very
#         similar strategy, perhaps with intervals. 
        
        
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



my @array = (0,1,2,4,5,6,8,9);
my @working;
my @ranges;

for (0..$#array-1) {
    if ($array[$_+1] - $array[$_] == 1) {
        $working[0] //= $array[$_  ];
        $working[1]   = $array[$_+1];
        next;
    }
    push @ranges, [ @working ] if @working;
    @working = ();
}

push @ranges, [ @working ] if @working;


say q([) . (join ',', $_->@*) . q(]) for @ranges;




