#!/usr/bin/env perl

# Challenge 074
#
# TASK #1 › Majority Element
# Submitted by: Mohammad S Anwar
# You are given an array of integers of size $N.
#
# Write a script to find the majority element. If none found then print -1.
#
# Majority element in the list is the one that appears more than
# floor(size_of_list/2).
#
# Example 1
# Input: @A = (1, 2, 2, 3, 2, 4, 2)
# Output: 2, as 2 appears 4 times in the list which is more than floor(7/2).
#
# Example 2
# Input: @A = (1, 3, 1, 2, 4, 5)
# Output: -1 as none of the elements appears more than floor(6/2).

use Modern::Perl;

my @A = @ARGV;
say majority_elem(@A);

sub majority_elem {
    my(@a) = @_;
    # count instances of each element, get max
    my %count;
    my $max_count = 0;
    my $max_elem;
    for (@a) {
        $count{$_}++;
        if ($count{$_} > $max_count) {
            ($max_count, $max_elem) = ($count{$_}, $_);
        }
    }
    # check if majority
    if ($max_count > int(@a/2)) {
        return $max_elem;
    }
    else {
        return -1;
    }
}
