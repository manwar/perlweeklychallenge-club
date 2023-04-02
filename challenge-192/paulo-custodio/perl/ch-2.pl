#!/usr/bin/perl

# Challenge 192
#
# Task 2: Equal Distribution
# Submitted by: Mohammad S Anwar
#
# You are given a list of integers greater than or equal to zero, @list.
#
# Write a script to distribute the number so that each members are same. If you
# succeed then print the total moves otherwise print -1.
#
# Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]
#
# 1) You can only move a value of '1' per move
# 2) You are only allowed to move a value of '1' to a direct neighbor/adjacent
# cell
#
#
# Example 1:
#
# Input: @list = (1, 0, 5)
# Output: 4
#
# Move #1: 1, 1, 4
# (2nd cell gets 1 from the 3rd cell)
#
# Move #2: 1, 2, 3
# (2nd cell gets 1 from the 3rd cell)
#
# Move #3: 2, 1, 3
# (1st cell get 1 from the 2nd cell)
#
# Move #4: 2, 2, 2
# (2nd cell gets 1 from the 3rd cell)
#
# Example 2:
#
# Input: @list = (0, 2, 0)
# Output: -1
#
# It is not possible to make each same.
#
# Example 3:
#
# Input: @list = (0, 3, 0)
# Output: 2
#
# Move #1: 1, 2, 0
# (1st cell gets 1 from the 2nd cell)
#
# Move #2: 1, 1, 1
# (3rd cell gets 1 from the 2nd cell)

use Modern::Perl;
use List::Util 'sum';

sub equalize_ {
    my($num_moves, @n)=@_;
    return $num_moves if @n<2;

    while (1) {
        return $num_moves if scalar(grep {$n[0]==$n[$_]} 0..$#n)==@n;

        # find biggest difference
        my $max_diff=0; my $max_from=0; my $max_to=0;
        for my $i (0..$#n-1) {
            for my $j ($i+1..$#n) {
                my $diff=abs($n[$i]-$n[$j]);
                if ($diff>$max_diff) {
                    $max_diff=$diff;
                    if ($n[$i]>$n[$j]) {
                        ($max_from,$max_to)=($i,$j);
                    }
                    else {
                        ($max_from,$max_to)=($j,$i);
                    }
                }
            }
        }
        return -1 if $max_diff==0;

        # move
        my $dir=$max_to>$max_from ? 1 : -1;
        $n[$max_from]--; $n[$max_from+$dir]++; $num_moves++;
    }
}

sub equalize {
    my(@n)=@_;
    my $avg=sum(@n)/@n;
    if (int($avg)==$avg) {
        return equalize_(0, @n);
    }
    else {
        return -1;
    }
}

say equalize(@ARGV);
