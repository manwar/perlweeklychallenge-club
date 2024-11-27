#!/bin/perl -w


use Data::Dump qw(dump);


# Task 1: Similar Dominos
# Submitted by: Mohammad Sajid Anwar
# You are given a list of dominos, @dominos.

# Write a script to return the number of dominoes that are similar to any other domino.

# $dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either (a = c and b = d) or (a = d and b = c).

# Example 1
# Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
# Output: 2

# Similar Dominos: $dominos[0], $dominos[1]
# Example 2
# Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
# Output: 3

# Similar Dominos: $dominos[0], $dominos[1], $dominos[3]



testMe(\&process, 'Example1', [[1, 3], [3, 1], [2, 4], [6, 8]], 2);
testMe(\&process, 'Example2', [[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]], 3);

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

    my $similar = 0;

    PIECE:
    for(my $i=0; $i<@$input1; ++$i) {

        for(my $j=0; $j<@$input1; ++$j) {

            next if ( $i==$j );

            if ( isSimilar($input1->[$i], $input1->[$j]) ) {
                ++$similar;
                next PIECE;
            }
            
            
        }


    }

    return $similar;

}


sub isSimilar {
    my $a = shift;
    my $b = shift;

    return ($a->[0]==$b->[0] && $a->[1]==$b->[1]) || ($a->[0]==$b->[1] && $a->[1]==$b->[0]);
}