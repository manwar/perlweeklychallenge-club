#!/usr/bin/env perl

# Challenge 303
#
# Task 2: Delete and Earn
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints.
#
# Write a script to return the maximum number of points you can earn by applying the following operation some number of times.
#
# Pick any ints[i] and delete it to earn ints[i] points.
# Afterwards, you must delete every element equal to ints[i] - 1
# and every element equal to ints[i] + 1.
# Example 1
# Input: @ints = (3, 4, 2)
# Output: 6
#
# Delete 4 to earn 4 points, consequently, 3 is also deleted.
# Finally delete 2 to earn 2 points.
# Example 2
# Input: @ints = (2, 2, 3, 3, 3, 4)
# Output: 9
#
# Delete a 3 to earn 3 points. All 2's and 4's are also deleted too.
# Delete a 3 again to earn 3 points.
# Delete a 3 once more to earn 3 points.

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";

say calc_earned(@ARGV);

sub calc_earned {
    my(@nums) = @_;
    my $max_earned = 0;

    my $calc_earned;
    $calc_earned = sub {
        my($earned, @pending) = @_;
        if (@pending == 0) {
            $max_earned = $earned if $max_earned < $earned;
        }
        else {
            for my $i (0 .. $#pending) {
                my $item = $pending[$i];
                my @new_pending = @pending;

                # remove current item;
                splice(@new_pending, $i, 1);

                # remove all equal to above and below
                @new_pending = grep {$_ != $item+1 && $_ != $item-1} @new_pending;

                $calc_earned->($earned+$item, @new_pending);
            }
        }
    };

    $calc_earned->(0, @nums);
    return $max_earned;
}
