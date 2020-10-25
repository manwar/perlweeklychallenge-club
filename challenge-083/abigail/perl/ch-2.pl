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
# This looks like an NP-complete program. 2-partition, where we're
# asked whether we can partition a set of integers into two sets with
# equal sums is NP-complete. That means, if you flip the signs of one
# of the sets, and add all numbers, the result is 0, which is minimal.
# 

#
# We solve this by using a stack of states. Each state means we're at
# some point processing @$set. We're keeping a running sum, by either
# adding or substracting the current number. We also keep a best score
# so far (best sum: smallest non-negative sum; best flips: least amount
# of flips to reach best sum). Each time we have processed the entire
# set, we see whether we have a better score. If we haven't reached
# the end of the set, we push two new states on the stack, one where
# we add to the running sum, and one where we subtract from the running
# sum. In the latter case, we increment the number of flips.
#
# To optimize, if we can early determine we can no longer reach a valid
# sum (that is, all future choices in this branch lead to negative sums),
# or if we cannot improve the current best score (that is, all future
# choices in this branch lead to a sum which is worse than the best sum)
# we return early, and don't push new states.
#
# As a final optimization, we also put the last number whose sign was
# flipped into the state. We use this to prevent pushing cases on
# the stack where the we add the current number, and the current number
# is equal to the last number whose sign was flipped. This makes that
# we process runs of equal number far more efficiently, reducing the
# amount of generated cases from exponential to linear.
#


#
# Read the numbers, and sort them.
#
my $set = [<> =~ /[0-9]+/g];
   $set = [sort {$b <=> $a} @$set];

#
# Initialize the best sums and best flips, by using a greedy algorithm.
#
my $best_sum   = 0;
my $best_flips = 0;

foreach my $number (@$set) {
    if ($best_sum -  $number < 0) {
        $best_sum += $number;
    }
    else {
        $best_sum -= $number;
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
# @todo will contain 4-tuples [$index, $sum, $flips, $last_flipped],
# each encoding a state.
#
#    - $index:        The current index
#    - $sum:          Sum of the numbers @$set [0 .. $index - 1], with
#                     zero of signs flipped.
#    - $flips:        The number of signs which have been flipped to reach $sum.
#    - $last_flipped: The last number whose sign we have flipped.
#
my @todo = [0, 0, 0, 0];
while (@todo) {
    my ($index, $sum, $flips, $last_flipped) = @{pop @todo};

    #
    # We can't reach a positive sum, so no need to continue this branch.
    #
    if ($sum + $$partial_sums [$index] < 0) {
        next;
    }

    #
    # If we can't improve on the current best score, no need to continue.
    #
    if ($sum - $$partial_sums [$index] >  $best_sum ||
        $sum - $$partial_sums [$index] == $best_sum &&
              $flips + @$set - $index  >= $best_flips) {
        next;
    }
    
    if ($index >= @$set) {
        #
        # We have exhausted the set. Do we have a better result?
        #
        if ($sum >= 0 &&
               ($sum < $best_sum || $sum == $best_sum && $flips < $best_flips)) {
            #
            # If so, update the score.
            #
            ($best_sum, $best_flips) = ($sum, $flips);
        }
        next;
    }

    #
    # Push the case where we are subtracting on the stack.
    #
    my $number = $$set [$index];
    push @todo => [$index + 1, $sum - $number, $flips + 1, $number];

    #
    # Push the case where we are adding on the stack, but
    # not if the current number equals the last number whose
    # sign was flipped.
    #
    push @todo => [$index + 1, $sum + $number, $flips,     $last_flipped]
          unless $last_flipped == $number;
}

say $best_flips;

__END__
