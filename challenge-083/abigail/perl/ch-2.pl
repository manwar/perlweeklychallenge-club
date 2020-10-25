#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# You are given an array @A of positive numbers.
#
# Write a script to flip the sign of some members of the given array
# so that the sum of the all members is minimum non-negative.
# 
# Given an array of positive elements, you have to flip the sign of
# some of its elements such that the resultant sum of the elements
# of array should be minimum non-negative(as close to zero as possible).
# Return the minimum no. of elements whose sign needs to be flipped
# such that the resultant sum is minimum non-negative.
#

#
# This is very similar to an NP-hard problem: partitioning a set into
# two, so that the difference of the sums is minimal is NP-hard. And
# this is equal to finding sign flips so the resulting sum is as close
# to zero as possible.
# 

#
# Some terminology:
#   - score:  Sum of a set of numbers, with zero or more signs flipped.
#   - set:    The given array.
#   - N:      The number of elements in set.
#

#
# Consider the search space of the possible solutions, that is, all
# the possible scores we can achieve by flipping zero or more signs
# of the set.
#
# We can visualize this as a complete binary tree of depth N + 1.
# Each node on depth i <= N corresponds to the i-th number in the set.
# The subtree on the left corresponds to adding the i-th number to 
# the score, the subtree on the right corresponds to subtracting the
# i-th number from the score.
# In each node we will have two numbers: the score (so far) we would get
# if we'd follow the path from the root to this node, and the number of
# signs we flipped along that path (that is, the number of times we
# decended into a right subtree.
# Leaf nodes correspond to having calculated a score for the entire set,
# the one with the lowest, non-negative, score wins, with ties broken
# by the least amount of flips.
#
# We can implement a standard stack based algorithm to do an in-order
# traversal of the tree, calculating (but not storing) the numbers in
# each node along the way. We visit each leaf node that way, and it is
# then a simple matter of finding the best score/least number of flips.
#
# But given an example set
#
#   S = [20, 20, 20, 19, 18, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
#
# this requires visiting 8,388,607 nodes.
#
# We can do better.
#
# Imagine we're traversing the tree, and we're now at some node at depth j.
# Let the score at this node be P, and the number of flips be F. We can
# then, without further traversing the tree, quickly calculate the maximum
# and minimum score we can reach from this subtree. Let Q be the sum of the
# numbers in the set with index >= j. Then the maximum score we can reach
# is P + Q, and the minimum P - Q. If P + Q is negative, there is no need
# to traverse the subtree under the current node, as all posible scores will
# be negative. Similar, if P - Q exceeds the current best score (or if
# P - Q equals the best score, but F + N - j + 1 exceeds to best number of
# flips) nothing in the subtree under the current tree can improve the best
# score found so far.
#
# In all of these cases, we can stop descending the tree, and backtrack.
#
# In order to quickly find sums of subtrees, we preprocess the set, and
# create an array partial_sums. $partial_sums [$j] contains the sum of
# the numbers @set [$j .. $#set].
#
# Applying this to the example set S requires visiting only 1265 nodes.
# Quite an improvement!
#
# But we still can do better.
#
# It may take a while before we have found a decent "best score". If we
# can start with a good estimate of the winning numbers, we can back out
# of the search more often. So, we first apply a greedy algorithm: we
# sort the set (largest to smallest), and iterate over the set, keeping
# running score. If we can subtract the current number from the running
# score, without the running score going negative, we subtract. Else, we
# add. And, of course, we tally the amount of times we subtracted.
#
# Applying this to S means we only visit 141 nodes.
#
# But there is more.
#
# Imagine the set contains a number multiple times. For instance, our
# example set S contains the number 20 three times. There are 8 different
# ways to flip its signs:
#
#     20   20   20
#     20   20  -20
#     20  -20   20
#     20  -20  -20
#    -20   20   20
#    -20   20  -20
#    -20  -20   20
#    -20  -20  -20
#
# But there are only four different sums: 60, 20, -20, -60. All that
# matters is of how many numbers the sign has been flipped.
# If we're keeping track of the last number we flipped on the current
# path (that is, the last time we decended into a right subtree),
# and don't go left if the number associated with the current node
# equals the number last flipped, we only follow unique path.
# The set of sequences above reduces to
#
#     20   20   20
#     20   20  -20
#     20  -20  -20
#    -20  -20  -20
#
# Now, with the example set S, we're down to visiting only 52 nodes.
#


#
# Read the numbers, and sort them.
#
my $set = [<> =~ /[0-9]+/g];
   $set = [sort {$b <=> $a} @$set];

#
# Initialize the best score and best flips, by using a greedy algorithm.
#
my $best_score = 0;
my $best_flips = 0;

foreach my $number (@$set) {
    if ($best_score -  $number < 0) {
        $best_score += $number;
    }
    else {
        $best_score -= $number;
        $best_flips ++;
    }
}

#
# Create a list of partial sums:
#     $$partial_sums [$i[ = sum @$set [$i .. $#$set];
#
# That is, each entry in $partial_sums is the sum of the elements in $set
# starting from the same index, till the end.
#
my $partial_sums;
$$partial_sums [@$set] = 0;
for (my $i = @$set; $i --;) {
    $$partial_sums [$i] = $$set [$i] + $$partial_sums [$i + 1];
}

#
# @todo will contain 4-tuples [$index, $score, $flips, $last_flipped],
# each encoding a state.
#
#    - $index:        The current index
#    - $score:        Sum of the numbers @$set [0 .. $index - 1], with
#                     zero of signs flipped.
#    - $flips:        The number of signs which have been flipped to
#                     reach $score.
#    - $last_flipped: The last number whose sign we have flipped.
#
my @todo = [0, 0, 0, 0];
while (@todo) {
    my ($index, $score, $flips, $last_flipped) = @{pop @todo};

    #
    # We can't reach a positive score, so no need to continue this branch.
    #
    if ($score + $$partial_sums [$index] < 0) {
        next;
    }

    #
    # If we can't improve on the current best score, no need to continue.
    #
    if ($score - $$partial_sums [$index] >  $best_score ||
        $score - $$partial_sums [$index] == $best_score &&
              $flips + @$set - $index  >= $best_flips) {
        next;
    }
    
    if ($index >= @$set) {
        #
        # We have exhausted the set. Do we have a better result?
        #
        if ($score >= 0 &&
               ($score < $best_score ||
                $score == $best_score && $flips < $best_flips)) {
            #
            # If so, update the score.
            #
            ($best_score, $best_flips) = ($score, $flips);
        }
        next;
    }

    #
    # Push the case where we are subtracting on the stack.
    #
    my $number = $$set [$index];
    push @todo => [$index + 1, $score - $number, $flips + 1, $number];

    #
    # Push the case where we are adding on the stack, but
    # not if the current number equals the last number whose
    # sign was flipped.
    #
    push @todo => [$index + 1, $score + $number, $flips,     $last_flipped]
          unless $last_flipped == $number;
}

say $best_flips;

__END__
