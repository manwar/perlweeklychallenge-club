#!/bin/perl -w


use Data::Dump qw(dump);


# Task 1: Unique Number
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints, where every elements appears more than once except one element.

# Write a script to find the one element that appears exactly one time.

# Example 1
# Input: @ints = (3, 3, 1)
# Output: 1
# Example 2
# Input: @ints = (3, 2, 4, 2, 4)
# Output: 3
# Example 3
# Input: @ints = (1)
# Output: 1
# Example 4
# Input: @ints = (4, 3, 1, 1, 1, 4)
# Output: 3


testMe(\&process, 'Example1', [3, 3, 1], 1);
testMe(\&process, 'Example2', [3, 2, 4, 2, 4], 3);
testMe(\&process, 'Example3', [1], 1);
testMe(\&process, 'Example4', [4, 3, 1, 1, 1, 4], 3);

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

    foreach my $v ( keys %$map ) {
        if ( $map->{$v}==1 ) {
            return $v;
        }
    }

    return -1;

}
