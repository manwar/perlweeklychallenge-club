#!/bin/perl -w


# Task 2: Digit Count Value
# Submitted by: Mohammad Sajid Anwar
# You are given an array of positive integers, @ints.

# Write a script to return true if for every index i in the range 0 <= i < size of array, the digit i occurs exactly the $ints[$i] times in the given array otherwise return false.

# Example 1
# Input: @ints = (1, 2, 1, 0)
# Ouput: true

# $ints[0] = 1, the digit 0 occurs exactly 1 time.
# $ints[1] = 2, the digit 1 occurs exactly 2 times.
# $ints[2] = 1, the digit 2 occurs exactly 1 time.
# $ints[3] = 0, the digit 3 occurs 0 time.
# Example 2
# Input: @ints = (0, 3, 0)
# Ouput: false

# $ints[0] = 0, the digit 0 occurs 2 times rather than 0 time.
# $ints[1] = 3, the digit 1 occurs 0 time rather than 3 times.
# $ints[2] = 0, the digit 2 occurs exactly 0 time.



testMe(\&process, 'Example1', [1, 2, 1, 0], 1);
testMe(\&process, 'Example2', [0, 3, 0], 0);
testMe(\&process, 'Example3', [1, 2, 1], 0);



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

    my $map = {};

    foreach my $v ( @$input1 ) {
        $map->{$v}++;
    }

    for(my $i=0; $i<@$input1; ++$i) {
        my $times = $input1->[$i];
        my $found = $map->{$i} || 0;

        # print "i=$i => found=$found times=$times\n";

        if ( $found!=$times ) {
            return 0;
        }
    }


    return 1;

}

