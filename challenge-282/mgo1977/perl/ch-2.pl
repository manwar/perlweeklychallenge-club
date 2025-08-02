#!/bin/perl -w


# Task 2: Changing Keys
# Submitted by: Mohammad Sajid Anwar
# You are given an alphabetic string, $str, as typed by user.

# Write a script to find the number of times user had to change the key to type the given string. Changing key is defined as using a key different from the last used key. The shift and caps lock keys won’t be counted.

# Example 1
# Input: $str = 'pPeERrLl'
# Ouput: 3

# p -> P : 0 key change
# P -> e : 1 key change
# e -> E : 0 key change
# E -> R : 1 key change
# R -> r : 0 key change
# r -> L : 1 key change
# L -> l : 0 key change
# Example 2
# Input: $str = 'rRr'
# Ouput: 0
# Example 3
# Input: $str = 'GoO'
# Ouput: 1


testMe(\&process, 'Example1', "pPeERrLl", 3);
testMe(\&process, 'Example2', "rRr", 0);
testMe(\&process, 'Example3', "GoO", 1);

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
        print "[ERR] $name :: got=$got, expectedValue=$expectedValue\n";
    }

}

sub process {
    my $input1 = shift;

    my @chars = split(//, $input1);

    my $len = @chars;

    my $changes = 0;

    for(my $i=0; $i<($len-1); ++$i) {

        my $thisChar = lc($chars[$i]);
        my $nextChar = lc($chars[$i+1]);

        if ( $thisChar ne $nextChar ) {
            ++$changes;
        }

    }

    return $changes;

}

