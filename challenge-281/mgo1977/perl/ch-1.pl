#!/bin/perl -w


use Data::Dump qw(dump);


# Task 1: Check Color
# Submitted by: Mohammad Sajid Anwar
# You are given coordinates, a string that represents the coordinates of a square of the chessboard as shown below:

# Week_281_Task_1

# Write a script to return true if the square is light, and false if the square is dark.

# Example 1
# Input: $coordinates = "d3"
# Output: true
# Example 2
# Input: $coordinates = "g5"
# Output: false
# Example 3
# Input: $coordinates = "e6"
# Output: true



testMe(\&process, 'Example1', "d3", 1);
testMe(\&process, 'Example2', "g5", 0);
testMe(\&process, 'Example3', "e6", 1);

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
    my $input1 = shift;

    if ( $input1 !~ /([a-h])([1-8])/i ) {
        return 0;
    }

    my ($a,$b) = ( charToInt($1), int($2));

    return ($a+$b)%2!=0;

}

sub charToInt {
    my $v = uc(shift);

    return ord($v) - ord('A') + 1;
}