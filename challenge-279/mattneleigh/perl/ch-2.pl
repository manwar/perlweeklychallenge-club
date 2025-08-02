#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "perl",
    "book",
    "good morning"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOuput: %s\n\n",
        $string,
        can_evenly_split_vowels($string) ? "true" : "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, determine whether it is possible to split a string into two
# substrings with an equal number of vowels
# Takes one argument:
# * A string to examine
# Returns:
# * A value that evaluates as true if it is possible to split the string into
#   two substrings with an equal number of vowels, and a value that evaluates
#   as false if it is not possible to split the string into two substrings with
#   an equal number of vowels; a false value will be returned if there are no
#   vaowels present
################################################################################
sub can_evenly_split_vowels{

    my $total = 0;

    # Split the word into individual letters and
    # count the vowels, case-insensitively
    foreach my $letter (split('', shift())){
        $total++
            if($letter =~ m/[aeiou]/i);
    }

    # Return true if we had vowels, and an even
    # number of them
    return($total && !($total % 2));

}



