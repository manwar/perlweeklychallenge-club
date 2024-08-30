#!/bin/perl -w


use Data::Dump qw(dump);


# Task 1: Lucky Integer
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints.

# Write a script to find the lucky integer if found otherwise return -1. If there are more than one then return the largest.

# A lucky integer is an integer that has a frequency in the array equal to its value.

# Example 1
# Input: @ints = (2, 2, 3, 4)
# Output: 2
# Example 2
# Input: @ints = (1, 2, 2, 3, 3, 3)
# Output: 3
# Example 3
# Input: @ints = (1, 1, 1, 3)
# Output: -1



testMe(\&process, 'Example1', [2, 2, 3, 4], 2);
testMe(\&process, 'Example2', [1, 2, 2, 3, 3, 3], 3);
testMe(\&process, 'Example3', [1, 1, 1, 3], -1);

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

    my $map = {};

    foreach my $v ( @$input1 ) {
        $map->{$v}++;
    }

    foreach my $v ( reverse sort keys %$map ) {
        if ( $map->{$v}==$v ) {
            return $v;
        }
    }

    return -1;

}
