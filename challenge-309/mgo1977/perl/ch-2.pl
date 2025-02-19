#!/bin/perl -w


# Task 2: Min Diff
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints.

# Write a script to find the minimum difference between any two elements.

# Example 1
# Input: @ints = (1, 5, 8, 9)
# Output: 1

# 1, 5 => 5 - 1 => 4
# 1, 8 => 8 - 1 => 7
# 1, 9 => 9 - 1 => 8
# 5, 8 => 8 - 5 => 3
# 5, 9 => 9 - 5 => 4
# 8, 9 => 9 - 8 => 1
# Example 2
# Input: @ints = (9, 4, 1, 7)
# Output: 2

# 9, 4 => 9 - 4 => 5
# 9, 1 => 9 - 1 => 8
# 9, 7 => 9 - 7 => 2
# 4, 1 => 4 - 1 => 3
# 4, 7 => 7 - 4 => 3
# 1, 7 => 7 - 1 => 6



testMe(\&process, 'Example1', [1, 5, 8, 9], 1);
testMe(\&process, 'Example2', [9, 4, 1, 7], 2);



sub testMe {
    my $processor = shift;
    my $name = shift;
    my $input1 = shift;
    my $expectedValue = shift;

    my $got = &$processor($input1);

    if ( $got==$expectedValue ) {
        print "[OK ] $name\n";
    }
    else {
        print "[ERR] $name :: got=$got, expectedValue=$expectedValue\n";
    }

}



sub process {
    my $input1 = shift;

    my $totalLen = @$input1;

    my $minDiff;

    for(my $i=0; $i<$totalLen; ++$i) {

        my $a = $input1->[$i];

        for(my $j=$i+1; $j<$totalLen; ++$j) {
            my $b = $input1->[$j];

            my $diff = abs($a - $b);

            if ( (not defined $minDiff) || $diff<$minDiff ) {
                $minDiff = $diff;
            }

        }

    }

    return $minDiff;

}


