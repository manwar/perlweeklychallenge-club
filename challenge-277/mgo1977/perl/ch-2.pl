#!/bin/perl -w

use feature 'signatures';

# Task 2: Strong Pair

# You are given an array of integers, @ints.

# Write a script to return the count of all strong pairs in the given array.

# A pair of integers x and y is called strong pair if it satisfies: 0 < |x - y| < min(x, y).

# Example 1
# Input: @ints = (1, 2, 3, 4, 5)
# Ouput: 4
# Strong Pairs: (2, 3), (3, 4), (3, 5), (4, 5)

# Example 2
# Input: @ints = (5, 7, 1, 7)
# Ouput: 1

# Strong Pairs: (5, 7)

testMe(\&process, 'Example1', [1, 2, 3, 4, 5], 4);
testMe(\&process, 'Example2', [5, 7, 1, 7], 1);

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

    my $alreadyProcessedPair = {};

    for(my $i=0; $i<$len; ++$i) {

        for(my $j=$i; $j<$len; ++$j) {

            my $v1 = $input[$i];
            my $v2 = $input[$j];

            my $pairName = $v1<$v2 ? "${v1}_$v2" : "${v2}_$v1";

            next if ( exists $alreadyProcessedPair->{$pairName} );

            $alreadyProcessedPair->{$pairName} = 1;

            my $modValue = abs($v1-$v2);

            if ( $modValue > 0 ) {

                my $minValue = $v1<$v2 ? $v1 : $v2;

                if ( $modValue < $minValue ) {
                    ++$result;
                }

            }

        }

    }

    return $result;
}



