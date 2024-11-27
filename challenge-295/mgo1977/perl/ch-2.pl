#!/bin/perl -w


# Task 2: Jump Game
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints.

# Write a script to find the minimum number of jumps to reach the last element. $ints[$i] represents the maximum length of a forward jump from the index $i. In case last element is unreachable then return -1.

# Example 1
# Input: @ints = (2, 3, 1, 1, 4)
# Output: 2

# Jump 1 step from index 0 then 3 steps from index 1 to the last element.
# Example 2
# Input: @ints = (2, 3, 0, 4)
# Output: 2
# Example 3
# Input: @ints = (2, 0, 0, 4)
# Output: -1



testMe(\&process, 'Example1', [2, 3, 1, 1, 4], 2);
testMe(\&process, 'Example2', [2, 3, 0, 4], 2);
testMe(\&process, 'Example3', [2, 0, 0, 4], -1);
testMe(\&process, 'Example4', [1, 1, 1, 1, 9], -1);
testMe(\&process, 'Example5', [1, 1, 1, 2, 9], 4);
testMe(\&process, 'Example6', [5, 0, 0, 0, 9], 1);
testMe(\&process, 'Example7', [4, 1, 0, 0, 9], 2);
testMe(\&process, 'Example8', [3, 1, 1, 0, 9], 3);
testMe(\&process, 'Example9', [2, 1, 1, 1, 9], 4);



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


    my $lengthToGet = @$input1;

    my $currentValue = 0;

    for(my $i=0; $i<$lengthToGet-1; ++$i) {

        $currentValue += $input1->[$i];

        if ( $currentValue >= $lengthToGet ) {
            return $i+1;
        }

    }

    return -1;

}


