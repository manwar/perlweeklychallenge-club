#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "0011",
    "0000",
    "1111",
    "0101",
    "011101"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %d\n\n",
        $string,
        calculate_max_score($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string consisting only of ones and zeros, calculate the maximum score
# that can be achieved by splitting the string into two portions of non-zero
# length, where the zeros (0) in the left portion and the ones (1) in the right
# portion are each worth one point
# Takes one argument:
# * The string to examine (e.g. "011101")
# Returns:
# * The maximum score calculated as descibed above (e.g. 5)
################################################################################
sub calculate_max_score{
    my $string = shift();

    my $max_position = length($string) - 1;
    my $left_score = 0;
    my $right_score = 0;
    my $max_score = 0;

    # Count the ones on the right side (which is
    # the whole string at this point)
    for my $i (0 .. $rightmost_pos){
        $right_score++
            if(substr($string, $i, 1));
    }

    # Scan the string from left to right, updating
    # the positional scores as appropriate; if a
    # new maximum score is seen, it will be stored
    $rightmost_pos--;
    for my $i (0 .. $rightmost_pos){
        if(substr($string, $i, 1)){
            $right_score--;
        } else{
            $left_score++
        }
        $max_score = $left_score + $right_score
            if(($left_score + $right_score) > $max_score);
    }

    return($max_score);

}



