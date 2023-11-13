#!/usr/bin/perl

#Task 1: Arithmetic Triplets
#
#You are given an array (3 or more members) of integers in increasing order and a positive integer.
#
#Write a script to find out the number of unique Arithmetic Triplets satisfying the following rules:
#
#a) i < j < k
#b) nums[j] - nums[i] == diff
#c) nums[k] - nums[j] == diff
#
#Example 1
#
#Input: @nums = (0, 1, 4, 6, 7, 10)
#       $diff = 3
#Output: 2
#
#Index (1, 2, 4) is an arithmetic triplet because both  7 - 4 == 3 and 4 - 1 == 3.
#Index (2, 4, 5) is an arithmetic triplet because both 10 - 7 == 3 and 7 - 4 == 3.

use strict;
use warnings;
use v5.28;


my @examples = (

    { nums => [ 0, 1, 4, 6, 7, 10 ], diff => 3, },
    { nums => [ 4, 5, 6, 7, 8, 9 ],  diff => 2, }
);

sub aritmetic_triplet {
    my $diff = shift;
    my @nums = @_;
    my $len_nums = scalar @nums;
    my $count = 0;

    for (my $i = 0; $i < $len_nums - 2; $i++) {
        for (my $j = $i + 1; $j < $len_nums - 1; $j++) {
            next unless ( ($nums[$j] - $nums[$i]) == $diff );

            for (my $k = $j + 1; $k < $len_nums; $k++) {
                next unless ( ($nums[$k] - $nums[$j]) == $diff );
                $count++;
            }
        }
    }

    return $count
}

foreach my $element (@examples) {
    my $at = aritmetic_triplet($element->{diff}, $element->{nums}->@*);
    say 'Input  : @nums = (', join(',', $element->{nums}->@*), ')'; 
    say '         $diff = ', $element->{diff};
    say "Output : $at\n"
    
}
