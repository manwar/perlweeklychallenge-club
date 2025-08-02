#!/bin/perl -w


use Data::Dump qw(dump);


# Task 1: Good Integer
# Submitted by: Mohammad Sajid Anwar
# You are given a positive integer, $int, having 3 or more digits.

# Write a script to return the Good Integer in the given integer or -1 if none found.

# A good integer is exactly three consecutive matching digits.

# Example 1
# Input: $int = 12344456
# Output: "444"
# Example 2
# Input: $int = 1233334
# Output: -1
# Example 3
# Input: $int = 10020003
# Output: "000"


testMe(\&process, 'Example1', 12344456, "444");
testMe(\&process, 'Example2', 1233334, -1);
testMe(\&process, 'Example3', 10020003, "000");

sub testMe {
    my $processor = shift;
    my $name = shift;
    my $input1 = shift;
    my $expectedValue = shift;

    my $got = &$processor($input1);

    if ( $got eq $expectedValue ) {
        print "[OK ] $name\n";
    }
    else {
        print "[ERR] $name :: got='$got', expectedValue='$expectedValue'\n";
    }

}


sub process {
    my $input1 = shift;

    my @chars = split(//, $input1);

    my $currentChar;
    my $count = 0;

    foreach my $char ( @chars ) {

        if ( (not defined $currentChar) || ($currentChar ne $char) ) {

            if ( $count==3 ) {
                return $currentChar x $count;
            }

            $currentChar = $char;
            $count = 1;
        }
        else {
            ++$count;
        }


 
    }

    if ( $count==3 ) {
        return $currentChar x $count;
    }    

    return -1;
}
