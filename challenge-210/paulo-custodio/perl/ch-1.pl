#!/usr/bin/perl

# Challenge 210
#
# Task 1: Kill and Win
# Submitted by: Mohammad S Anwar
#
# You are given a list of integers.
#
# Write a script to get the maximum points. You are allowed to take out (kill)
# any integer and remove from the list. However if you do that then all
# integers exactly one-less or one-more would also be removed. Find out the
# total of integers removed.
# Example 1
#
# Input: @int = (2, 3, 1)
# Output: 6
#
# First we delete 2 and that would also delete 1 and 3. So the maximum points
# we get is 6.
#
# Example 2
#
# Input: @int = (1, 1, 2, 2, 2, 3)
# Output: 11
#
# First we delete 2 and that would also delete both the 1's and the 3. Now we
# have (2, 2).
# Then we delete another 2 and followed by the third deletion of 2. So the
# maximum points we get is 11.

use Modern::Perl;
use List::Util 'sum';

sub kill_and_win {
    my(@n)=@_;
    return 0 if @n==0;
    # kill one and recurse
    my $max=0;
    for my $i (0..$#n) {
        my $kill=$n[$i];
        my @copy=@n;
        splice(@copy,$i,1);                             # remove kill value
        my $value=$kill+sum(0,grep {$_==$kill+1 || $_==$kill-1} @copy);
        @copy=grep {$_!=$kill+1 && $_!=$kill-1} @copy;  # remove above and below
        $value+=kill_and_win(@copy);
        $max=$value if $max<$value;
    }
    return $max;
}

say kill_and_win(@ARGV);
