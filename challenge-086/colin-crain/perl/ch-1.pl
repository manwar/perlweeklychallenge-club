#! /opt/local/bin/perl
#
#       difference_engine.pl
#
#         TASK #1 › Pair Difference
#         Submitted by: Mohammad S Anwar
#         You are given an array of integers @N and an integer $A.
#
#         Write a script to find find if there exists a pair of elements in the
#         array whose difference is $A.
#
#         Print 1 if exists otherwise 0.
#
#         Example 1:
#             Input: @N = (10, 8, 12, 15, 5) and $A = 7
#             Output: 1 as 15 - 8 = 7
#         Example 2:
#             Input: @N = (1, 5, 2, 9, 7) and $A = 6
#             Output: 1 as 7 - 1 = 6
#         Example 3:
#             Input: @N = (10, 30, 20, 50, 40) and $A = 15
#             Output: 0

#         method:
#             a gentle warm-up for the second challenge, this task requires us
#             to find combinations of integers from a set that can produce a
#             certain value as a difference. It's worth noting that it's not
#             specified, only implied by the examples, that the numbers be
#             positive. I see no compelling reason to require this, so we won't.
#
#             We only need to do the calculations in one direction; positive
#             values can be turned into their negative counterparts by reversing
#             the values:
#
#             a - b = c  -->  b - a = -c
#
#             Rather than compute a list of combinations and trying them out, we
#             can try and constrict the search space by first sorting the list
#             in descending order. Then we can start iterating over the values.
#             Even if the first value is not greater than the target, it can
#             theoretically be reduced to fit by subtracting a negative number.
#             We take the next value and subtract it. If the difference is less
#             than the target, we can continue, subtracting a smaller amount
#             with the next value until we match or exceed the goal. One thing
#             is certain, that the computed differences will grow as we move the
#             second value to the right along the list. Consequently, if we
#             exceed the target we immediately move the initial value forward
#             one step.
#
#             What of negative values you ask? Well if we take the absolute
#             value of the target in the beginning we match against that. By use
#             of the equality mentioned above we can change the sign by
#             reversing the values as required. Which we don't have to actually do,
#             we only need to know we can and act on that.

#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

## default looks for value -115 from array
scalar @ARGV == 0 and @ARGV = (-115, 100, 25, 15, 0 , -1, -2, -100);

my ($target, @input) = @ARGV;

my @sorted = sort {$b-$a} @input;


for my $m (0..scalar @input - 1) {
    for my $n ($m..scalar @input - 1) {
        say 1 and exit if $sorted[$m] - $sorted[$n] == abs $target;
    }
}
say 0;









## ## ## ## ## SUBS:

