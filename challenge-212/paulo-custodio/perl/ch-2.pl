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
    my($count, @nums) = @_;
    return -1 unless scalar(@nums) % $count == 0;
    my $group_size = scalar(@nums) / $count;
    @nums = sort {$a<=>$b} @nums;
    my @output;
    for my $i (0..$count-1) {
        my @group;
        my %seen;
        my $j = 0;
        while (scalar(@group) < $group_size) {
            if (!$seen{$nums[$j]}++) {
                push @group, $nums[$j];
                splice(@nums, $j, 1);
            }
            else {
                $j++;
                if ($j >= @nums) {
                    return -1;
                }
            }
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
my $count = pop(@nums);
print_groups(rearrange_groups($count, @nums));
