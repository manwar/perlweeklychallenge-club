#!/bin/perl -w

# You are given an array of integers, @hours.
# Write a script to return the number of pairs that forms a complete day.
# A complete day is defined as a time duration that is an exact multiple of 24 hours.

# Example 1
# Input: @hours = (12, 12, 30, 24, 24)
# Output: 2
#
# Pair 1: (12, 12)
# Pair 2: (24, 24)

# Example 2
# Input: @hours = (72, 48, 24, 5)
# Output: 3

# Pair 1: (72, 48)
# Pair 2: (72, 24)
# Pair 3: (48, 24)

# Example 3
# Input: @hours = (12, 18, 24)
# Output: 0

testMe(\&process, 'Example1', [12, 12, 30, 24, 24], 2);
testMe(\&process, 'Example2', [72, 48, 24, 5], 3);
testMe(\&process, 'Example3', [12, 18, 24], 0);

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

    my $numberOfPairs = 0;

    for(my $i=0; $i < $len; ++$i) {

        my $v1 = $input[$i];

        for(my $j=$i+1; $j < $len; ++$j) {

            my $v2 = $input[$j];

            if ( ($v1+$v2)%24==0 ) {
                ++$numberOfPairs;
            }

        }

    }

    return $numberOfPairs;
}


