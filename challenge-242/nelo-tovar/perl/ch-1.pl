#!/usr/bin/env perl

# Task 1: Missing Members
# 
# You are given two arrays of integers.
# 
# Write a script to find out the missing members in each other arrays.
# Example 1
# 
# Input: @arr1 = (1, 2, 3)
#        @arr2 = (2, 4, 6)
# Output: ([1, 3], [4, 6])
# 
# (1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
# (2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).
# 
# Example 2
# 
# Input: @arr1 = (1, 2, 3, 3)
#        @arr2 = (1, 1, 2, 2)
# Output: ([3])
# 
# (1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since they are same, keep just one.
# (1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).


use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    [ [ 1, 2, 3 ], 
      [ 2, 4, 6 ], 
    ],
    [ [ 1, 2, 3, 3 ], 
      [ 1, 1, 2, 2 ], 
    ],
);

sub missing_members {
    my $a1 = shift;
    my $a2 = shift;

    my @missing1;
    my @missing2;

    
    no warnings;
    foreach my $element (@$a1) {
        next if ( $element ~~ @$a2);
        push @missing1, $element unless ($element ~~ @missing1);
    }

    foreach my $element (@$a2) {
        next if ( $element ~~ @$a1);
        push @missing2, $element unless ($element ~~ @missing2);
    }
    use warnings;

    return [[@missing1], [@missing2]];
}

for my $e (@examples) {
    my @arr1 = $e->[0]->@*;
    my @arr2 = $e->[1]->@*;

    my $mm = missing_members(\@arr1, \@arr2);
    say 'Input : @arr1 = ', dump(\@arr1);
    say '        @arr2 = ', dump(\@arr2);
    say 'Output : ', dump($mm);
    say ' ';
}
