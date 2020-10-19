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
# So, we might as well opt for a dumb, inefficient program. We'll
# loop from 0 to 2^@A - 1. Given a number 0 <= $n < 2^@A - 1, we'll
# look at the binary representation, and use this to sum the numbers
# of @A: if bit b of $n is 0, we flip the sign of $A [b]. It's then
# just a matter of keeping track of the best score (closer to 0
# beats further away from 0, if the same distance, less flipped
# signs is better).
#

use List::Util qw [sum];

#
# Read the input, store numbers in @A. $l is the size of @A.
#
my @A = <> =~ /[0-9]+/g;
my $l = @A;

#
# Keep track of the best sum, and least number of flips (for the
# cases with the best sum).
#
my $best_sum     = sum @A;
my $best_flipped =     @A;

#
# Iterate from 0 to 2^@A - 1
#
for (my $n = 0; $n < 2 ** @A; $n ++) {
    #
    # Get the flips corresponding to $n:
    #    - Get the binary representation of $n, zero-padded
    #      to the length of @A.
    #    - Split on characters
    #    - Multiply by 2, subtract 1: this turns 0 into -1, and keeps 1 as is.
    #
    my @flips   = map {2 * $_ - 1} split // => sprintf "%0${l}b" => $n;

    #
    # Calculate the sum: add each number, multiplied by -1 or 1
    #
    my $sum     = sum map {$flips [$_] * $A [$_]} keys @A;

    #
    # Count how many flips we have.
    #
    my $flipped = grep {$_ < 0} @flips;

    #
    # Do we have an improvement? For that
    #    - The sum should be non-negative and
    #    - Either the sum is less than the best found,
    #    - Or equal to the best sum found, but we less flips
    #
    if ($sum >= 0 &&
          ($sum <  $best_sum ||
           $sum == $best_sum && $flipped < $best_flipped)) {
        #
        # Remember the best sum, and best number of flips so far.
        #
        $best_sum     = $sum;
        $best_flipped = $flipped;
    }
}

#
# Print the result
#
say $best_flipped;

__END__
