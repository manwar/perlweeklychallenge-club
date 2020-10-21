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
# We are opting for a recursive solution. For each element of the set,
# we try two possibilities: once where the flip the sign of the current
# number, and once where we do not.
#
# Our recursive method takes the following parameters:
#
#     - $set:       A reference to the array of numbers, which is assumed to
#                   sorted (largest number first). We will not modify the
#                   array, nor pass different arrays. 
#     - $index:     The index of the current number, 0 when first called.
#     - $sum:       The current sum. This is the sum of all numbers, where
#                   the signs of the numbers with index < $index may have
#                   been flipped, but none of the signs of the numbers with
#                   index >= $index. When first called, $sum is the sum of
#                   all numbers in $set.
#     - $flips:     This is number of numbers with index < $index which have
#                   been flipped. When first called, this is 0.
#     - $last_skip: This is the last value for we did NOT flip a sign.
#                   If the current number equals $last_skip, we will NOT
#                   recurse for the case the sign of the number is flipped.
#
# Recursion stops if any of the following conditions is true:
#     - $sum < 0.        In that case, no matter which future choices we
#                        make, we cannot end up with a non-negative sum. So,
#                        we return undef, signalling a failure.
#     - $sum == 0.       In this case, if we were to flip any of the signs
#                        of the future numbers, the sum would become negative.
#                        So we return the 0, and the number of flips.
#     - $index >= @$set. We have processed the entire set, and no more
#                        decisions can be made. So, we return $set and $flips.
#
# After recursing twice, we pick the best solution. That is, the one with
# the least defined sum, and if both cases returns in the same sum, we pick
# the one with the least amount of flips.
#

use List::Util qw [sum];

sub min_flips;
sub min_flips ($set, $index     = 0,
                     $sum       = sum (@$set),
                     $flips     = 0,
                     $last_skip = $$set [$index] + 1) {

    #
    # If the sum is less than 0, we don't have a result.
    #
    return if $sum < 0;

    #
    # We're done if either the sum = 0, or we have exhausted the set.
    #
    return ($sum, $flips) if $index >= @$set || $sum == 0;

    #
    # Recurse twice. Once where we flip the sign of the current number,
    # and once where we do not.
    #
    my ($sum1, $flips1, $sum2, $flips2);
    ($sum1, $flips1) = min_flips $set, $index + 1,
                                       $sum - 2 * $$set [$index],
                                       $flips + 1,
                                       $last_skip if $$set [$index] != $last_skip;
    ($sum2, $flips2) = min_flips $set, $index + 1,
                                       $sum,
                                       $flips,
                                       $$set [$index];
    #
    # Return the best result. Note that the first recursion may return undef.
    # The second will never.
    #
    return if !defined $sum1 && !defined $sum2;
    if (defined $sum1 && ($sum1 <  $sum2 ||
                          $sum1 == $sum2 && $flips1 < $flips2)) {
        return ($sum1, $flips1)
    }
    else {
        return ($sum2, $flips2)
    }
}

#
# Read the input, sort it, call min_flips, and print the result.
#
my $set = [sort {$b <=> $a} <> =~ /[0-9]+/g];
say +(min_flips $set) [1];


__END__
