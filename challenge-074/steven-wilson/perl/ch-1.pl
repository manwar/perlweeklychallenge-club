#!/usr/bin/env perl
# Week74 Task 1
# You are given an array of integers of size $N.
#
# Write a script to find the majority element. If none found then
# print -1.
#
#     Majority element in the list is the one that appears more than
#     floor(size_of_list/2).
#
# Example 1
# Input: @A = (1, 2, 2, 3, 2, 4, 2)
# Output: 2, as 2 appears 4 times in the list which is more than
# floor(7/2).
#
# Example 2
# Input: @A = (1, 3, 1, 2, 4, 5)
# Output: -1 as none of the elements appears more than
# floor(6/2).

use strict;
use warnings;
use feature qw/ say /;
use POSIX qw/ floor /;

my @A1 = ( 1, 2, 2, 3, 2, 4, 2 );
say find_majority_element( \@A1 );
my @A2 = ( 1, 3, 1, 2, 4, 5 );
say find_majority_element( \@A2 );

sub find_majority_element {
    my $elements_ref = shift;
    my @elements     = @{$elements_ref};
    my $majority     = floor( scalar @elements / 2 );
    my %count_of_elements;
    map { $count_of_elements{$_}++ } @elements;
    for ( keys %count_of_elements ) {
        if ( $count_of_elements{$_} > $majority ) {
            return $_;
        }
    }
    return -1;
}
