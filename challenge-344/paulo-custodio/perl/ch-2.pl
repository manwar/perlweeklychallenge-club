#!/usr/bin/env perl

# Challenge 344
#
# Task 2: Array Formation
# Submitted by: Mohammad Sajid Anwar
# You are given two list: @source and @target.
#
# Write a script to see if you can build the exact @target by putting these smaller lists from @source together in some order. You cannot break apart or change the order inside any of the smaller lists in @source.
#
#
# Example 1
# Input: @source = ([2,3], [1], [4])
#        @target = (1, 2, 3, 4)
# Output: true
#
# Use in the order: [1], [2,3], [4]
#
# Example 2
# Input: @source = ([1,3], [2,4])
#        @target = (1, 2, 3, 4)
# Output: false
#
# Example 3
# Input: @source = ([9,1], [5,8], [2])
#        @target = (5, 8, 2, 9, 1)
# Output: true
#
# Use in the order: [5,8], [2], [9,1]
#
# Example 4
# Input: @source = ([1], [3])
#        @target = (1, 2, 3)
# Output: false
#
# Missing number: 2
#
# Example 5
# Input: @source = ([7,4,6])
#        @target = (7, 4, 6)
# Output: true
#
# Use in the order: [7, 4, 6]

use Modern::Perl;

@ARGV==2 or die "usage: #0 'n n, n n, ...' 'n n n'\n";
my($source, $target) = @ARGV;
my @parts = split /,/, $source;
my @source = map {[split ' ', $_]} @parts;
my @target = split ' ', $target;

say array_formed(\@source, \@target) ? "true" : "false";

sub array_formed {
    my($source, $target) = @_;
    my @source = @$source;
    my @target = @$target;

main_loop:
    while (@target) {
        return unless @source;
        # find a starting segment
        for my $i (0 .. $#source) {
            my @segment = @{$source[$i]};
            next unless @segment;
            if (is_prefix(\@target, \@segment)) {
                @target = @target[ scalar(@segment) .. $#target ];
                splice(@source, $i, 1);
                next main_loop;
            }
        }
        return;
    }
    return 1;
}

sub is_prefix {
    my($a, $b) = @_;
    my @a = @$a;
    my @b = @$b;
    for (my $i = 0; $i < @a && $i < @b; $i++) {
        return if $a[$i] != $b[$i];
    }
    return 1;
}
