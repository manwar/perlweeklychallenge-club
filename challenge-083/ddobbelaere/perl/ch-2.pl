#!/usr/bin/perl

=pod
TASK #2 › Flip Array
Submitted by: Mohammad S Anwar

You are given an array @A of positive numbers.

Write a script to flip the sign of some members of the given array so that the sum of the all members is minimum non-negative.

Given an array of positive elements, you have to flip the sign of some of its elements such that the resultant sum of the elements of array should be minimum non-negative(as close to zero as possible). Return the minimum no. of elements whose sign needs to be flipped such that the resultant sum is minimum non-negative.
=cut

use v5.30;
use warnings;

# Note: this naive implementation has exponential time complexity (as a function of input vector length)!
# For a more efficient implementation, see https://www.ijcai.org/Proceedings/09/Papers/096.pdf and https://en.wikipedia.org/wiki/Karmarkar%27s_algorithm.
# Also note that multiple solutions might exist, but in that case only one possible answer is returned.
sub flip_count_minimum_non_negative {
    my @A = @_;

    my $min_sum;
    my $answer;

    for my $sign_bitmask ( 0 .. 2**( @A - 1 ) - 1 ) {
        my $num_signs = 0;
        my $sum       = 0;

        for my $a (@A) {
            if ( $sign_bitmask % 2 ) {

                # Negative sign.
                $sum -= $a;
                $num_signs++;
            }
            else {
                # Positive sign.
                $sum += $a;
            }

            $sign_bitmask /= 2;
        }

        # "Flip signs" if sum is negative.
        # This reduces the worst case running time by a factor of 2,
        # as we can assume the sign of the last element is fixed.
        if ( $sum < 0 ) {
            $num_signs = @A - $num_signs;
            $sum *= -1;
        }

        # Update minimum.
        if ( not defined($min_sum) or ( $sum < $min_sum ) ) {
            $min_sum = $sum;
            $answer  = $num_signs;
        }

        # Early stop criterion.
        last if $min_sum == 0;
    }

    return $answer;
}

if (@ARGV) {

    # Console interface.
    say flip_count_minimum_non_negative(@ARGV);
}
else {
    say "Usage: perl $0 <list of numbers>";
    exit 1;
}
