#!/bin/perl -w

use feature 'signatures';

# You are given an array of positive integers, @ints.
# Write a script to return the total number of elements in the given array which have the highest frequency.

# Example 1
# Input: @ints = (1, 2, 2, 4, 1, 5)
# Ouput: 4

# The maximum frequency is 2.
# The elements 1 and 2 has the maximum frequency.


# Example 2
# Input: @ints = (1, 2, 3, 4, 5)
# Ouput: 5

# The maximum frequency is 1.
# The elements 1, 2, 3, 4 and 5 has the maximum frequency.


testMe(\&process, 'Example1', [1, 2, 2, 4, 1, 5], 4);
testMe(\&process, 'Example2', [1, 2, 3, 4, 5], 5);
testMe(\&process, 'Example3', [1, 2, 2, 3, 2, 4, 6, 5, 5], 3);

sub testMe {
    my $processor = shift;
    my $name = shift;
    my $input = shift;
    my $expectedValue = shift;

    my $got = &$processor(@$input);

    if ( $got==$expectedValue ) {
        print "[OK ] $name\n";
    }
    else {
        print "[ERR] $name :: got=$got, expectedValue=$expectedValue\n";
    }

}

sub process {
    my @input = @_;

    my $len = @input;

    my $result = 0;

    my $map = {};

    for(my $i=0; $i < $len; ++$i) {
        $map->{$input[$i]}++;
    }

    my $maxValue = (sort { $b <=> $a } values %$map)[0];

    foreach my $key (@input) {

        my $value = $map->{$key};

        if ( $value == $maxValue ) {
            ++$result;
        }

    }

    return $result;
}



