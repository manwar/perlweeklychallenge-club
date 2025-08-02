#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "The Weekly Challenge",
    "   Hello   World    ",
    "Let's begin the fun"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %d\n\n",
        $string,
        length_of_last_word($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the length of the last word, defined as a sequence of
# non-whitespace characters, in a string
# Takes one argument:
# * The string to examine (e.g. "The Weekly Challenge")
# Returns:
# * The length of the last non-whitespace entity within the string (e.g. 9)
# NOTE: If punctuation or other non-whitespace characters that should not be
# counted are present in the string, it is the caller's responsibility to
# remove them before passing the string to this function
################################################################################
sub length_of_last_word{

    return(
        # 2) Determine the last word's length
        length(
            # 1) Extract the last word from the string
            (split(" ", shift()))[-1]
        )
    );

}



