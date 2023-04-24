#!/usr/bin/perl

# Challenge 212
#
# Task 2: Rearrange Groups
# Submitted by: Mohammad S Anwar
#
# You are given a list of integers and group size greater than zero.
#
# Write a script to split the list into equal groups of the given size where
# integers are in sequential order. If it can’t be done then print -1.
#
# Example 1:
#
# Input: @list = (1,2,3,5,1,2,7,6,3) and $size = 3
# Output: (1,2,3), (1,2,3), (5,6,7)
#
# Example 2:
#
# Input: @list = (1,2,3) and $size = 2
# Output: -1
#
# Example 3:
#
# Input: @list = (1,2,4,3,5,3) and $size = 2
# Output: (1,2,3), (3,4,5)
#
# Example 4:
#
# Input: @list = (1,5,2,6,4,7) and $size = 3
# Output: -1

use Modern::Perl;

sub rearrange_groups {
    my($size, @nums) = @_;
    return -1 unless scalar(@nums) % $size == 0;
    my %nums; $nums{$_}++ for @nums;
    my @output;
    while (%nums) {
        my $min = (sort {$a<=>$b} keys %nums)[0];
        my @group;
        for my $j ($min .. $min+$size-1) {
            return -1 unless $nums{$j};
            push @group, $j;
            $nums{$j}--;
            delete $nums{$j} if $nums{$j}==0;
        }
        push @output, \@group;
    }
    return @output;
}

sub print_groups {
    my(@output) = @_;
    if (@output==1 && !ref($output[0])) {
        say $output[0];
    }
    else {
        my $sep = "";
        for (@output) {
            print $sep,"(",join(",", @$_),")";
            $sep = ", ";
        }
        print "\n";
    }
}

my @nums = @ARGV;
my $size = pop(@nums);
print_groups(rearrange_groups($size, @nums));
