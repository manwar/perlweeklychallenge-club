#!/bin/perl

use strict;
use v5.28;

use List::Util 'sum';

if ($#ARGV > 0) {can_split(@ARGV) ? say 'true' : say 'false'};

sub can_split {
    my @nums = sort {$b <=> $a} (@_);
    my $maxindex = scalar @nums;
    my $avg = sum(@nums) / scalar(@nums);
    my (@list1, @list2, $sum1, $sum2);

    for (my $i = 0; $i < $maxindex; $i++) {
        if (scalar @list1 == 0) {
            push @list1, @nums[0];
            $sum1 += @nums[0];
            splice @nums, 0, 1;
        } elsif (scalar @list2 == 0) {
            push @list2, @nums[0];
            $sum2 += @nums[0];
            splice @nums, 0, 1;
        } else {
            if (abs(($sum1 / @list1) - $avg) >= abs(($sum2 / @list2) - $avg)) {
                if ($sum1 / @list1 <= $avg) {
                    push @list1, @nums[0];
                    $sum1 += @nums[0];
                    splice @nums, 0, 1;
                } else {
                    push @list1, @nums[$#nums];
                    $sum1 += @nums[$#nums];
                    splice @nums, $#nums, 1;
                }
            } else {
                if ($sum2 / @list2 <= $avg) {
                    push @list2, @nums[0];
                    $sum2 += @nums[0];
                    splice @nums, 0, 1;
                } else {
                    push @list2, @nums[$#nums];
                    $sum2 += @nums[$#nums];
                    splice @nums, $#nums, 1;
                }
            }
        }
    }
    $sum1 / scalar @list1 == $sum2 / scalar @list2 ? return 1 : return 0;
}
