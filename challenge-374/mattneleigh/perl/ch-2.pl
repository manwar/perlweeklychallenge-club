#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "6777133339",
    "1200034",
    "44221155",
    "88888",
    "11122233"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %d\n\n",
        $string,
        maximum_same_digit_string($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string consisting only of digits (0-9), find the largest number
# within that can be made from a sequence of identical digits
# Takes one argument:
# * The string of digits to examine (e.g. "6777133339")
# Returns:
# * The largest value made up of a string of identical digits from the provided
#   string (e.g. 3333)
################################################################################
sub maximum_same_digit_string{
    my $num = shift();

    my @same_digit_strings;
    my $max_same_digit_string = 0;

    # Loop over groups of identical digits
    while($num =~ m/((\d)\2*)/g){
        # Store this group if its numerical value is
        # the largest yet seen
        $max_same_digit_string = $1
            if($1 > $max_same_digit_string);
    }

    return($max_same_digit_string);

}



