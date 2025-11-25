#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "textbook",
    "aaaaa",
    "hoorayyy",
    "x",
    "aabcccddeeffffghijjk"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %d\n\n",
        $string,
        calculate_string_power($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, calculate the Power of the string, where the string's Power
# is defined as the longest substring containing only one unique repeated
# character
# Takes one argument:
# * The string to examine (e.g. "aabcccddeeffffghijjk")
# Returns:
# * The calculated Power of the string as defined above (e.g. 4)
################################################################################
sub calculate_string_power{
    my $string = shift();

    my $max = 0;

    # Search the entire string for substrings of repeated
    # characters
    while($string =~ m/((.)\2*)/g){
        # If this substring is the longest yet seen, store its
        # length
        $max = length($1)
            if(length($1) > $max);
    }

    return($max);

}



