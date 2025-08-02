#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "acbddbca",
    "abccd",
    "abcdabbb"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: \"%s\"\n\n",
        $string,
        first_duplicate_letter($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string of lower-case English letters, determine which letter is the
# first to appear twice
# Takes one argument:
# * A string of lower case English letters (e.g. "abcdabbb")
# Returns:
# * The first letter that appears more than once in the string (e.g. "a") OR
#   the empty string if no letter appears at least twice
################################################################################
sub first_duplicate_letter{

    my %letters;

    # Loop over each letter
    foreach my $letter (split('', shift())){
        # Increment this letter's count
        $letters{$letter}++;

        # If this letter has a count of 2, return it
        return($letter)
            if($letters{$letter} == 2);
    }

    # If we got here, no letter appeared twice
    return("");

}



