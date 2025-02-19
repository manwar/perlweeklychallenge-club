#!/bin/perl -w


use Data::Dump qw(dump);


# Task 1: Min Gap
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints, increasing order.

# Write a script to return the element before which you find the smallest gap.

# Example 1
# Input: @ints = (2, 8, 10, 11, 15)
# Output: 11

#  8 - 2  => 6
# 10 - 8  => 2
# 11 - 10 => 1
# 15 - 11 => 4

# 11 is where we found the min gap.
# Example 2
# Input: @ints = (1, 5, 6, 7, 14)
# Output: 6

#  5 - 1 => 4
#  6 - 5 => 1
#  7 - 6 => 1
# 14 - 7 => 7

# 6 and 7 where we found the min gap, so we pick the first instance.
# Example 3
# Input: @ints = (8, 20, 25, 28)
# Output: 28

#  8 - 20 => 14
# 25 - 20 => 5
# 28 - 25 => 3

# 28 is where we found the min gap.




testMe(\&process, 'Example1', [2, 8, 10, 11, 15], 11);
testMe(\&process, 'Example2', [1, 5, 6, 7, 14], 6);
testMe(\&process, 'Example3', [8, 20, 25, 28], 28);
testMe(\&process, 'Example4', [1, 2], 2);

sub testMe {
    my $processor = shift;
    my $name = shift;
    my $input1 = shift;
    my $expectedValue = shift;

    my $got = &$processor($input1);

    if ( $got == $expectedValue ) {
        print "[OK ] $name\n";
    }
    else {
        print "[ERR] $name :: got='$got', expectedValue='$expectedValue'\n";
    }

}


sub process {
    my $list = shift;

    my $len = @$list;

    my $minGap;
    my $minGapElement;

    for(my $i=0; $i+1<$len; ++$i) {
        my $a = $list->[$i];
        my $b = $list->[$i+1];

        my $gap = $b - $a;

        if ( (not defined $minGap) || $gap<$minGap ) {
            $minGap = $gap;
            $minGapElement = $b;
        }

    }


    return $minGapElement;
}

